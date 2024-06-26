library ieee;
use ieee.std_logic_1164.all;

entity key2ascii is
    port (
        key_code : in std_logic_vector(7 downto 0);
        ascii_code : out std_logic_vector(7 downto 0)
    );
end key2ascii;

architecture arch of key2ascii is
begin
    with key_code select
        ascii_code <=
            "10011000" when "01000101",
            "10011011" when "00010110",
            "00110010" when "00011110",
            "00110011" when "00100110",
            "00110100" when "00100101",
            "00110101" when "00101110",
            "00110110" when "00110110",
            "00110111" when "00111101",
            "00111000" when "00111110",
            "00111001" when "01000110",
            
            "01000001" when "00011100",
            "01000010" when "00110010",
            "01000011" when "00100001",
            "01000100" when "00100011",
            "01000101" when "00100100",
            "01000110" when "00101011",
            "01000111" when "00110100",
            "01001000" when "00110011",
            "01001001" when "01000011",
            "01001010" when "00111011",
            "01001011" when "01000010",
            "01001100" when "01001011",
            "01001101" when "00111010",
            "01001110" when "00110001",
            "01001111" when "01000100",
            "01010000" when "01001101",
            "01010001" when "00010101",
            "01010010" when "00101101",
            "01010011" when "00011011",
            "01010100" when "00101100",
            "01010101" when "00111100",
            "01010110" when "00101010",
            "01010111" when "00011101",
            "01011000" when "00100010",
            "01011001" when "00110101",
            "01011010" when "00011010",
            
            "01100000" when "00001110",
            "00101101" when "01001110",
            "00111101" when "01010101",
            "01011011" when "01010100",
            "01011101" when "01011011",
            "01011100" when "01011101",
            "00111011" when "01001100",
            "00100111" when "01010010",
            "00101100" when "01000001",
            "00101110" when "01001001",
            "00101111" when "01001010",
            
            "00100000" when "00101001",
            "00001101" when "01011010",
            "00001000" when "01100110",
            
            "00101010" when others;
end arch;
