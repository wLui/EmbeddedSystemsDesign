library IEEE;
use IEEE.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture tb of counter_tb is

  component clock_div
  port (
    clk : in std_logic;
    div : out std_logic;
  	cnt:  out std_logic_vector (25 downto 0)
  );
  end component;

  signal tb_clk : std_logic := '0';
  signal tb_cnt : std_logic_vector (25 downto 0) := (others => '0');
  signal tb_div : std_logic := '0';
  
begin

  dut: clock_div port map (clk => tb_clk, div => tb_div,cnt => tb_cnt);

  -- desired: a 125MHz clock
  -- observe 1/(125*10^6) = 8 ns, the desired period of our simulated clock
  process begin
    for iter in 0 to 4 loop
      tb_clk <= '0';
      wait for 4 ns;
      tb_clk <= '1';
      wait for 4 ns;
    end loop;
  end process;
  
end tb;

