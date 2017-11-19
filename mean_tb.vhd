library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mean_tb is
end mean_tb;

architecture tester of mean_tb is

  component mean is
    generic(n:integer:=8;
            m:integer:=3);
    port(clk  :in std_logic;
         rst  : in std_logic;
         din  : in std_logic_vector(n-1 downto 0);
         mean_val : out std_logic_vector(n-1 downto 0));
  end component mean;

  signal clk : std_logic;
  signal rst : std_logic;
  constant period : time :=50 ns;
  signal din : std_logic_vector(7 downto 0);
  signal mean_value : std_logic_vector(7 downto 0);

  begin

  UUT : mean generic map(n=>8,
                         m=>3)
    port map(clk=>clk,
             rst=>rst,
             din=>din,
             mean_val=>mean_value);

  process
  begin
    clk<='1';
    wait for period/2;
    clk<='0';
    wait for period/2;
  end process;

  process
  begin
    rst<='1';
    din<=x"01";
    wait for period;
    rst<='0';
    din<=x"02";
    wait for period;
    din<=x"03";
    wait for period;
    din<=x"04";
    wait for period;
    din<=x"05";
    wait for period;
    din<=x"06";
    wait for period;
    din<=x"07";
    wait for period;
    din<=x"08";
    wait for period;
    din<=x"00";
    wait for period;
  end process;

end tester;
