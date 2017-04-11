library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
generic (n:integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      en    : in std_logic;
      dout  : out std_logic_vector(n-1 downto 0));
end entity counter;

architecture behavior of counter is
signal tmp    : std_logic_vector(n-1 downto 0);
begin
U_clk : process(clk)
  begin
    if (clk'event and clk='1') then
        if (rst='1') then
          tmp<=(others=>'0');
        elsif (en='1') then
          tmp<=std_logic_vector(unsigned(tmp)+1);
        else
          tmp<=tmp;
        end if;
      end if;
  end process U_clk;
dout<=tmp;
end behavior;
