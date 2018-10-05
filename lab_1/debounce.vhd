library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    port( 
            clk   : in std_logic;
            Reset : in std_logic;
            btn   : in std_logic;
            dbnc  : out std_logic);
            
end debounce;

architecture behavioral of debounce is

constant COUNT_MAX : integer := 20; 

constant high_btn : std_logic := '1';

signal count : integer := 0;
type value_type is (idle,wait_time); 
signal value : value_type := idle;

begin
  
process(Reset,clk)
begin
    if(Reset = '1') then
        value <= idle;
        dbnc <= '0';
   elsif(rising_edge(clk)) then
        case (value) is
            when idle =>
                if(btn = high_btn) then  
                    value <= wait_time;
                else
                    value <= idle; 
                end if;
                dbnc <= '0';
            when wait_time =>
                if(count = COUNT_MAX) then
                    count <= 0;
                    if(btn = high_btn) then
                        dbnc <= '1';
                    end if;
                    value <= idle;  
                else
                    count <= count + 1;
                end if; 
        end case;       
    end if;        
end process;                  
                                                                                
end behavioral;
