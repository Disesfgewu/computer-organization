library ieee;
use ieee.std_logic_1164.all;

entity kb_code is
    generic (
        W_SIZE : integer := 2  -- 2 words in FIFO
    );
    port (
        clk, reset    : in std_logic;
        ps2d, ps2c    : in std_logic;
        rd_key_code   : in std_logic;
        kb_buf_empty  : out std_logic;
        key_code      : out std_logic_vector (7 downto 0)
    );
end kb_code;

architecture arch of kb_code is
    constant BRK : std_logic_vector (7 downto 0) := "11110000"; -- Break code
    type statetype is (wait_brk, get_code);
    signal state_reg, state_next : statetype;
    signal scan_done_tick, got_code_tick : std_logic;
    signal scan_out, w_data : std_logic_vector (7 downto 0);
begin
    -- Instantiation
    ps2_rx_unit : entity work.ps2_rx(arch)
        port map (
            clk          => clk,
            reset        => reset,
            rx_en        => '1',
            ps2d         => ps2d,
            ps2c         => ps2c,
            rx_done_tick => scan_done_tick,
            dout         => scan_out
        );

    fifo_key_unit : entity work.fifo(arch)
        generic map (
            B    => 8,
            W    => W_SIZE
        )
        port map (
            clk    => clk,
            reset  => reset,
            rd     => rd_key_code,
            wr     => got_code_tick,
            w_data => scan_out,
            empty  => kb_buf_empty,
            full   => open,
            r_data => key_code
        );

    -- FSM to get the scan code after Break received
    process (clk, reset)
    begin
        if reset = '1' then
            state_reg <= wait_brk;
        elsif clk'event then
        	if clk = '1' then
	            state_reg <= state_next;
        	end if;
        end if;
    end process;

    process (state_reg, scan_done_tick)
    begin
        got_code_tick <= '0';
        state_next <= state_reg;
        case state_reg is
            when wait_brk =>
                -- wait for Break code
                if scan_done_tick = '1' then
                    state_next <= get_code;
                end if;
            when get_code =>
                -- get the following scan code after Break
                if scan_out = BRK then
                    got_code_tick <= '1';
                    state_next <= wait_brk;
                end if;
        end case;
    end process;
end arch;
