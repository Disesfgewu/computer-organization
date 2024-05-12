library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_key2ascii is
end tb_key2ascii;

architecture tb of tb_key2ascii is

    component key2ascii
        port (key_code   : in std_logic_vector (7 downto 0);
              ascii_code : out std_logic_vector (7 downto 0));
    end component;

    signal key_code   : std_logic_vector (7 downto 0);
    signal ascii_code : std_logic_vector (7 downto 0);

begin

    dut : key2ascii
    port map (key_code   => key_code,
              ascii_code => ascii_code);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        key_code <= (others => '0');
		for i in 0 to 255 loop
        	key_code <= std_logic_vector(to_unsigned(i, 8));
        	wait for 10 ns;
    	end loop;
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_key2ascii of tb_key2ascii is
    for tb
    end for;
end cfg_tb_key2ascii;