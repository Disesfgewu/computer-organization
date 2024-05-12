library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ps2_rx is
    port (
        clk, reset    : in  std_logic;
        ps2d, ps2c    : in  std_logic;
        rx_en         : in  std_logic;
        rx_done_tick  : out std_logic;
        dout          : out std_logic_vector(7 downto 0)
    );
end ps2_rx;

architecture arch of ps2_rx is
    type state_type is (idle, dps, load);
    signal state_reg, state_next : state_type;
    signal filter_reg, filter_next : std_logic_vector(7 downto 0);
    signal f_ps2c_reg, f_ps2c_next : std_logic;
    signal n_reg, n_next : unsigned(3 downto 0);
    signal b_reg, b_next : std_logic_vector(10 downto 0);
    signal fall_edge : std_logic;
begin

    -- Filter and falling edge signal generation
    process (clk, reset)
    begin
        if reset = '1' then
            filter_reg <= (others => '0');
            f_ps2c_reg <= '0';
        elsif clk'event then
        	if clk = '1' then
	            filter_reg <= filter_next;
	            f_ps2c_reg <= f_ps2c_next;
        	end if;
        end if;
    end process;
    
    filter_next <= ps2c & filter_reg(7 downto 1);
    f_ps2c_next <= '1' when filter_reg = "11111111" else
                   '0' when filter_reg = "00000000" else
                   f_ps2c_reg;
    process ( clk )
	begin
    	if clk = '1' then
		    fall_edge <= ps2c and not f_ps2c_reg;
    	end if;
    end process;
    -- State machine process
    process (clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
            n_reg <= (others => '0');
            b_reg <= (others => '0');
        elsif clk'event then
        	if clk = '1' then
            	state_reg <= state_next;
            	n_reg <= n_next;
            	b_reg <= b_next;
             end if;
        end if;
    end process;
    
    process ( state_reg , n_reg , b_reg , fall_edge , rx_en , ps2d )
    begin
    	rx_done_tick <= '0';
        state_next <= state_reg;
        case state_reg is
        	when idle =>
            	if fall_edge = '1' then
                	if rx_en = '1' then
		                b_next <= ps2d & b_reg(10 downto 1);
    	                n_next <= to_unsigned(9, n_reg'length);
 	        	        state_next <= dps;    
                	end if;
                end if;
            when dps =>
                if fall_edge = '1' then 
                    b_next <= ps2d & b_reg(10 downto 1);
                    if n_reg = 0 then  
                        state_next <= load;
                    else 
                        n_next <= n_reg - 1;
                    end if;
                end if;
            when load =>
                state_next <= idle;
                rx_done_tick <= '1';   
         end case;
    end process;
    dout <= b_reg(8 downto 1);      
end arch;
