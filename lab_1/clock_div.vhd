library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_div is
port (
  clk : in std_logic; -- input is a clock- a 1 bit signal
  div : out std_logic; -- output is also a clock- a 1 bit signal 
  cnt : out std_logic_vector (25 downto 0) -- include cnt for debugging purposes
);
end clock_div;

architecture div of clock_div is
  -- from calculation if the input is a 125 MHz clock and we want a 2 Hz clock,
  -- we need 61.25M pulses to get to that at the 2 Hz mark.
  -- 61.25M may be expressed as a 26 bit signal
  signal count : std_logic_vector (25 downto 0) := (others => '0'); 
begin

  -- div is 0 to begin with, and we want it to change to 1 when count is equal
  -- to 111...11
  cnt <= count;

  process(clk) begin
    if rising_edge(clk) then
      count <= std_logic_vector( unsigned(count) + 1 ); -- increment count
    end if;
    -- desired logic below
    -- if count = 61.25M, set div = 1 (should be rising edge)
    -- else if div = 1, set it back to 0
  end process;

end div;
