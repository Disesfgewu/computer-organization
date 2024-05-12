library ieee;
use ieee.std_logic_1164.all;

entity tb_kb_monitor is
end tb_kb_monitor;

architecture tb of tb_kb_monitor is

    component kb_monitor
        port (clk   : in std_logic;
              reset : in std_logic;
              ps2d  : in std_logic;
              ps2c  : in std_logic;
              tx    : out std_logic);
    end component;

    signal clk   : std_logic;
    signal reset : std_logic;
    signal ps2d  : std_logic;
    signal ps2c  : std_logic;
    signal tx    : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : kb_monitor
    port map (clk   => clk,
              reset => reset,
              ps2d  => ps2d,
              ps2c  => ps2c,
              tx    => tx);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;
	ps2c <= TbClock;
    stimuli : process
    begin
        ps2d <= '0';
        clk <= '0';
		reset <= '1';
        
        wait for 50 ns;
        
        reset <= '0';
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

configuration cfg_tb_kb_monitor of tb_kb_monitor is
    for tb
    end for;
end cfg_tb_kb_monitor;