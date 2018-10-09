library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clock_div is       -- define entity
port ( 
    clk,reset: in std_logic;   -- define inputs clk and reset
    div: out std_logic);       -- define output div
end clock_div;
  
architecture behavior of clock_div is     -- create architecture
  
signal cnt: integer:=1;                 --create signal for cpunt
signal clock_out : std_logic := '0';    --create signal for output clock
  
begin
  
process(clk,reset)   -- Process with if statements to increment counter
begin
    if(reset='1') then
        cnt<=1;
        clock_out<='0';
        elsif(rising_edge(clk)) then
            cnt <=cnt+1;
            if (cnt = 31250000) then       -- count-31250000 (125MHz/Desired Clock)/2
            clock_out <= NOT clock_out;
            cnt <= 1;
        end if;
    end if;
div <= clock_out;
end process;
  
end behavior;