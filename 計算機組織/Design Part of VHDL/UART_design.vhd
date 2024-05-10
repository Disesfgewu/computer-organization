library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity your_entity_name is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        rd_uart : out STD_LOGIC;
        wr_uart : in STD_LOGIC;
        w_data : out STD_LOGIC_VECTOR (7 downto 0);
        scan_done_tick : in STD_LOGIC;
        wr_uart_sig : in STD_LOGIC;
        ascii_code : out STD_LOGIC_VECTOR (7 downto 0);
        hex_in : out STD_LOGIC_VECTOR (3 downto 0);
        rx : out STD_LOGIC;
        tx_full : out STD_LOGIC;
        rx_empty : out STD_LOGIC;
        r_data : in STD_LOGIC;
        tx : in STD_LOGIC
    );
end your_entity_name;

architecture Behavioral of your_entity_name is

    component uart is
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            rd_uart : out STD_LOGIC;
            wr_uart : in STD_LOGIC;
            w_data : out STD_LOGIC_VECTOR (7 downto 0);
            scan_done_tick : in STD_LOGIC;
            wr_uart_sig : in STD_LOGIC;
            ascii_code : out STD_LOGIC_VECTOR (7 downto 0);
            hex_in : out STD_LOGIC_VECTOR (3 downto 0);
            rx : out STD_LOGIC;
            tx_full : out STD_LOGIC;
            rx_empty : out STD_LOGIC;
            r_data : in STD_LOGIC;
            tx : in STD_LOGIC
        );
    end component;

    signal tx_temp : std_logic;

begin

    uart_inst : uart
        port map (
            clk => clk,
            reset => reset,
            rd_uart => rd_uart,
            wr_uart => wr_uart_sig,
            w_data => w_data,
            scan_done_tick => scan_done_tick,
            wr_uart_sig => wr_uart_sig,
            ascii_code => ascii_code,
            hex_in => hex_in,
            rx => '1', -- assuming this is a constant value
            tx_full => open, -- assuming this is an open signal
            rx_empty => open, -- assuming this is an open signal
            r_data => open, -- assuming this is an open signal
            tx => tx_temp -- using a temporary signal for tx
        );

    -- Connect the temporary tx signal to the actual tx port
    tx <= tx_temp;

end Behavioral;
