vhd file 
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








testbench file

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY clock_div_tb IS
END clock_div_tb;
 
ARCHITECTURE behavior OF clock_div_tb IS
 
COMPONENT clock_div
PORT(
clk : IN std_logic;
reset : IN std_logic;
div : OUT std_logic
);
END COMPONENT;
 
--Inputs
signal clk : std_logic := '0';
signal reset : std_logic := '0';
 
--Outputs
signal div : std_logic;
 
-- Clock period definitions
constant clk_period : time := 8 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: clock_div PORT MAP (
clk => clk,
reset => reset,
div => div
);
 
-- Clock process definitions
clk_process :process
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;
 
-- Stimulus process
stim_proc: process
begin
wait for 100 ns;
reset <= '1';
wait for 100 ns;
reset <= '0';
wait;
end process;
 
END;
