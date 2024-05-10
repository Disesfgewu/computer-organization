-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 9.5.2024 11:03:21 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_ps2_rx is
end tb_ps2_rx;

architecture tb of tb_ps2_rx is

    component ps2_rx
        port (clk          : in std_logic;
              reset        : in std_logic;
              ps2d         : in std_logic;
              ps2c         : in std_logic;
              rx_en        : in std_logic;
              rx_done_tick : out std_logic;
              dout         : out std_logic_vector (7 downto 0));
    end component;

    signal clk          : std_logic;
    signal reset        : std_logic;
    signal ps2d         : std_logic;
    signal ps2c         : std_logic;
    signal rx_en        : std_logic;
    signal rx_done_tick : std_logic;
    signal dout         : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ps2_rx
    port map (clk          => clk,
              reset        => reset,
              ps2d         => ps2d,
              ps2c         => ps2c,
              rx_en        => rx_en,
              rx_done_tick => rx_done_tick,
              dout         => dout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;
	ps2c <= TbClock;
    
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
--         clk <= '0';
        ps2d <= '0';
        rx_en <= '0';
        clk <= '0';
		reset <= '1';
--         wait for 50 ns;
        -- Reset generation
        -- EDIT: Check that reset is really your reset signal=
        wait for 50 ns;
        
        reset <= '0';
        rx_en <= '1';
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '1'; clk <= '1';
        wait for 100 ns;
        ps2d <= '1'; clk <= '0';
        wait for 100 ns;
        ps2d <= '0'; clk <= '1';
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

configuration cfg_tb_ps2_rx_test of tb_ps2_rx_test is
    for tb
    end for;
end cfg_tb_ps2_rx_test;