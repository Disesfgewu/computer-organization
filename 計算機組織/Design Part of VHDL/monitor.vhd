library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity kb_monitor is
	port ( 
    	clk, reset : in std_logic;
        ps2d , ps2c : in std_logic;
        tx : out std_logic
    );
end kb_monitor;

architecture arch of kb_monitor is
	constant SP: std_logic_vector ( 7 downto 0 ):= "00100000";
    type statetype is ( idle , send1 , send0 , sendb );
    signal state_reg, state_next : statetype;
    signal scan_data , w_data: std_logic_vector( 7 downto 0 );
    signal scan_done_tick , wr_uart : std_logic;
    signal ascii_code : std_logic_vector( 7 downto 0 );
    signal hex_in : std_logic_vector ( 3 downto 0 );
begin
	ps2_rx_unit: entity work.ps2_rx( arch )
    	    port map (clk          => clk,
              reset        => reset,
              ps2d         => ps2d,
              ps2c         => ps2c,
              rx_en        => '1',
              rx_done_tick => scan_done_tick,
              dout         => scan_data);
    uart_unit: entity work.uart( str_arch )
    	port map ( clk => clk,
        		   reset => reset,
                   rd_uart => '0',
                   wr_uart => wr_uart,
                   rx => '1',
                   w_data => w_data,
                   tx_full => open,
                   rx_empty => open,
                   r_data => open,
                   tx => tx );
    process( clk , reset )
    begin
    	if reset = '1' then
        	state_reg <= idle;
        elsif clk'event then
        	if clk = '1' then
            	state_reg <= state_next ;
            end if;
        end if;
    end process;
   
   	process( state_reg , scan_done_tick , ascii_code )
    begin 
    	wr_uart <= '0';
        w_data <= SP ;
        state_next <= state_reg ;
        case state_reg is
        	when idle => 
            	if scan_done_tick = '1' then
                	state_next <= send1;
                end if;
            when send1 =>
            	w_data <= ascii_code;
                wr_uart <= '1';
                state_next <= send0;
            when send0 =>
            	w_data <= ascii_code;
                wr_uart <= '1';
                state_next <= sendb;
            when sendb =>
            	w_data <= SP;
                wr_uart <= '1';
                state_next <= idle;
       	end case;
	end process;

	hex_in <= scan_data ( 7 downto 4 ) when state_reg = send1 else
    		  scan_data ( 3 downto 0 );
    
    with hex_in select 
    	ascii_code <= 
        	"00110000" when "0000" ,
            "00110001" when "0001" ,
            "00110010" when "0010" ,
            "00110011" when "0011" ,
            "00110100" when "0100" ,
            "00110101" when "0101" ,
            "00110110" when "0110" ,
            "00110111" when "0111" ,
            "00111000" when "1000" ,
            "00111001" when "1001" ,
            "01000001" when "1010" ,
            "01000010" when "1011" ,
            "01000011" when "1100" ,
            "01000100" when "1101" ,
            "01000101" when "1110" ,
            "01000110" when others ;
end arch;            