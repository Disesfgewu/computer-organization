library ieee;
use ieee.std_logic_1164.all;

entity tb_kb_code is
end tb_kb_code;

architecture tb of tb_kb_code is

    component kb_code
        port (clk          : in std_logic;
              reset        : in std_logic;
              ps2d         : in std_logic;
              ps2c         : in std_logic;
              rd_key_code  : in std_logic;
              kb_buf_empty : out std_logic;
              key_code     : out std_logic_vector (7 downto 0));
    end component;

    signal clk          : std_logic;
    signal reset        : std_logic;
    signal ps2d         : std_logic;
    signal ps2c         : std_logic;
    signal rd_key_code  : std_logic;
    signal kb_buf_empty : std_logic;
    signal key_code     : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : kb_code
    port map (clk          => clk,
              reset        => reset,
              ps2d         => ps2d,
              ps2c         => ps2c,
              rd_key_code  => rd_key_code,
              kb_buf_empty => kb_buf_empty,
              key_code     => key_code);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    --  YOURCLOCKSIGNAL <= TbClock;
	ps2c <= TbClock;
    stimuli : process
    begin
        ps2d <= '0';
        clk <= '0';
		reset <= '1';
        rd_key_code <= '1';
        wait for 50 ns;
        
        reset <= '0';
        rd_key_code <= '0';
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        -- EDIT Add stimuli here
        wait for 10 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_kb_code of tb_kb_code is
    for tb
    end for;
end cfg_tb_kb_code;