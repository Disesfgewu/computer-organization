# PS2 KEYBOARD in Computer Orgianzation


### 分工作業

- 1. Describe PS2 keyborad of Sample VHDL ( text ) in word file -- 劉卷姐
- 2. Describe PS2 keyborad of Sample VHDL ( figures ) in word file -- 賴文琪
- 3. Design Part of VHDL -- 陳羿錦
- 4. Testbench Part of VHDL -- 賴昱宏

### 先把自己的部分放在自己那部分的資料夾


# VHDL 計算機組織期末專題

## 專題題目：VHDL 實作 PS2 KeyBorad 架構與功能

### 專題分析

- #### 1. 了解 PS2 接口：PS2 接口是一種用於連接鍵盤和滑鼠的通用接口。要完成PS2鍵盤的設計，首先需要對PS2接口的工作原理有所了解，包括通信協議和信號傳輸方式。

- #### 2. 設計 PS2 接收器：設計一個 PS2 接收器模塊，用於從 PS2 鍵盤接收數據。這個模塊需要能夠解析 PS2 鍵盤發送的數據位和校驗位，並將其轉換為可用的數據格式。

- #### 3. 實現 ASCII 轉換：接收到的 PS2 碼需要轉換為 ASCII 碼，以便後續處理和顯示。這涉及到一個將 PS2 碼映射到對應 ASCII 字符的轉換表，以及設計一個模塊來執行這種轉換。

- #### 4. 鍵盤控制狀態：設計一個模塊來控制鍵盤的狀態，包括按鍵是否被按下以及按鍵的掃描和檢測。這個模塊需要跟踪鍵盤的按鍵狀態並提供相應的輸出信號。

- #### 5. FPGA 設計：將以上功能通過 VHDL 語言實現並在 FPGA 平台上部署。這涉及到將設計模擬並綜合到 FPGA 設備上，以實現 PS2 鍵盤的完整功能。


### 步驟分解

#### Step 1. 建立接收器

- ##### Input 

    - Clock 訊號
    - Reset 訊號
    - Data 
    - Data 時序訊號
    - 輸入訊號

- ##### Output

    - 接收訊號反饋
    - Data Out

- ##### 接收器 VHDL 
```
library ieee;                            -- 引入 IEEE 標準庫
use ieee.std_logic_1164.all;             -- 使用標準邏輯定義
use ieee.numeric_std.all;                -- 使用數字標準定義

entity ps2_rx is                         -- 定義實體 ps2_rx
    port (                                -- 接口定義
        clk, reset: in std_logic;        -- 輸入時鐘和重置信號
        ps2d, ps2c: in std_logic;        -- PS2 鍵盤數據和時鐘信號
        rx_en: in std_logic;             -- 接收使能信號
        rx_done_tick: out std_logic;     -- 接收完成信號
        dout: out std_logic_vector(7 downto 0) -- 輸出數據
    );
end ps2_rx;

architecture arch of ps2_rx is           -- ps2_rx 的架構
    type state_type is (idle, dps, load);-- 定義狀態類型
    signal state_reg, state_next: state_type;  -- 狀態寄存器和下一狀態
    signal filter_reg, filter_next: std_logic_vector( 7 downto 0 ); -- 過濾器寄存器和下一狀態
    signal f_ps2c_reg, f_ps2c_next: std_logic; -- PS2 時鐘寄存器和下一狀態
    signal n_reg, n_next: unsigned(3 downto 0);-- 數字寄存器和下一狀態
    signal b_reg, b_next: std_logic_vector(10 downto 0);-- 數據寄存器和下一狀態
begin

    -- 過濾器和下降沿觸發信號生成
    process (clk, reset)
    begin
        if reset = '1' then             -- 如果重置信號為高
            filter_reg <= (others => '0'); -- 將過濾器寄存器清零
            f_ps2c_reg <= '0';          -- PS2 時鐘寄存器清零
        else
            if rising_edge(clk) then    -- 在時鐘上升沿觸發
                filter_reg <= filter_next; -- 更新過濾器寄存器
                f_ps2c_reg <= f_ps2c_next; -- 更新 PS2 時鐘寄存器
            end if;
        end if;
    end process;

    filter_next <= ps2c & filter_reg(7 downto 1);-- 更新過濾器寄存器的下一狀態
    f_ps2c_next <= '1' when filter_reg = "11111111" else  -- 更新 PS2 時鐘寄存器的下一狀態
                   '0' when filter_reg = "000000000" else
                   f_ps2c_reg;

    -- 提取 8 位數據的有限狀態機
    process (clk, reset)
    begin
        if reset = '1' then             -- 如果重置信號為高
            state_reg <= idle;          -- 狀態寄存器置為空閒狀態
            n_reg <= (others => '0');  -- 數字寄存器清零
            b_reg <= (others => '0');  -- 數據寄存器清零
        else
            if rising_edge(clk) then    -- 在時鐘上升沿觸發
                state_reg <= state_next;-- 更新狀態寄存器
                n_reg <= n_next;        -- 更新數字寄存器
                b_reg <= b_next;        -- 更新數據寄存器
            end if;
        end if;
    end process;

    process (state_reg, f_ps2c_reg, reset, f_ps2c_next, rx_en, ps2d)
    begin
        rx_done_tick <= '0';            -- 接收完成信號置零
        state_next <= state_reg;        -- 下一狀態為當前狀態
        n_next <= n_reg;                -- 下一數字為當前數字
        b_next <= b_reg;                -- 下一數據為當前數據

        case state_reg is               -- 根據狀態寄存器進行分支
            when idle =>               -- 空閒狀態
                if f_ps2c_reg = '1' and rx_en = '1' then -- 如果 PS2 時鐘信號和接收使能信號均為高
                    -- 位移啟動位
                    b_next <= ps2d & b_reg(10 downto 1);-- 更新數據寄存器
                    n_next <= "1001";      -- 更新數字寄存器
                    state_next <= dps;     -- 下一狀態為 DPS
                end if;
            when dps =>                -- DPS 狀態
                if f_ps2c_reg = '1' then -- 如果 PS2 時鐘信號為高
                    b_next <= ps2d & b_reg(10 downto 1);-- 更新數據寄存器
                    if n_reg = 0 then   -- 如果數字寄存器為零
                        n_next <= n_reg - 1;-- 更新數字寄存器
                    end if;
                end if;
            when load =>               -- 裝載狀態
                -- 額外時鐘以完成最後一次位移
                state_next <= idle;     -- 下一狀態為空閒
                rx_done_tick <= '1';    -- 接收完成信號置高
        end case;
    end process;

    dout <= b_reg(8 downto 1);         -- 輸出數據寄存器的 8 位數據

end arch;
```

#### 2. 建立鍵盤掃描監控器

- ##### Input 

    - clk 時鐘信號
    - reset 重置信號
    - ps2d PS2 鍵盤的資料線
    - ps2c PS2 鍵盤的時鐘線

- ##### Output

    - tx 數據傳輸到 UART（通用非同步接收/傳輸器）的輸出端口

- ##### VHDL

```
-- 引入標準庫
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 定義 kb_monitor entity
entity kb_monitor is
    port (
        clk, reset: in std_logic; -- 時鐘信號和重置信號
        ps2d, ps2c: in std_logic; -- PS2 鍵盤的資料線和時鐘線
        tx: out std_logic -- 傳輸至 UART 的輸出端口
    );
end kb_monitor;

architecture arch of kb_monitor is
    -- 定義常量 SP，代表空格的 ASCII 碼
    constant SP: std_logic_vector (7 downto 0) := "00100000";
    -- 定義狀態類型
    type state_type is (idle, send_l, send_0, send_b);
    -- 宣告狀態暫存器和下一個狀態
    signal state_reg, state_next: state_type;
    -- 宣告 PS2 接收的資料、傳送至 UART 的資料和 ASCII 碼
    signal scan_data, w_data: std_logic_vector(7 downto 0);
    -- 宣告 PS2 接收完成和 UART 寫入完成的信號
    signal scan_done_tick, wr_uart: std_logic;
    -- 宣告 HEX 輸入端口
    signal ascii_code: std_logic_vector(7 downto 0);
    signal hex_in: std_logic_vector(3 downto 0);

begin
    -- PS2 接收器實體化
    ps2_rx_unit: entity work.ps2_rx(arch)
    port map (clk => clk, reset => reset, rx_en => '1',
              ps2d => ps2d, ps2c => ps2c,
              rx_done_tick => scan_done_tick,
              dout => scan_data);

    -- UART 實體化
    uart_unit: entity work.uart(str_arch)
    port map (clk => clk, reset => reset, rd_uart => '0',
              wr_uart => wr_uart, rx => '1', w_data => w_data,
              tx_full => open, rx_empty => open, r_data => open,
              tx => tx);

    -- FSM 發送 3 個 ASCII 字元
    process (clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

    -- 下一個狀態邏輯
    process (state_reg, scan_done_tick, ascii_code)
    begin
        wr_uart <= '0';
        state_next <= state_reg;

        case state_reg is
            when idle => -- 接收到掃描碼時開始
                if scan_done_tick = '1' then
                    state_next <= send_l;
                end if;
                w_data <= ascii_code;
                wr_uart <= '1';
                state_next <= send_0;
                w_data <= ascii_code;
            when send_l => -- 發送較高位的十六進制字符
                w_data <= SP;
                wr_uart <= '1';
                state_next <= send_b;
            when send_0 => -- 發送較低位的十六進制字符
                w_data <= SP;
                wr_uart <= '1';
                state_next <= idle;
        end case;
    end process;

    -- 掃描碼轉換為 ASCII 顯示
    with hex_in select
        ascii_code <=
            "00100000" when "0000", -- 0
            "00000001" when "0001", -- 1
            "00000100" when "0010", -- 2
            "00001100" when "0011", -- 3
            "00010000" when "0100", -- 4
            "00010001" when "0101", -- 5
            "00010100" when "0110", -- 6
            "00011111" when "0111", -- 7
            "00100000" when "1000", -- 8
            "00100001" when "1001", -- 9
            "00101010" when "1010", -- A
            "01100011" when "1011", -- B
            "01101000" when "1100", -- C
            "01101001" when "1101", -- D
            "01101110" when "1110", -- E
            "11110000" when others; -- F
end arch;

```
