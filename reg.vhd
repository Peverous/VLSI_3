library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
  generic(n:integer:=8);
  port(clk  : in std_logic;
       rst  : in std_logic;
       din  : in std_logic_vector(n-1 downto 0);
       dout : out std_logic_vector(n-1 downto 0));
end reg;

architecture behavior of reg is
begin
  U_clk : process(clk)
  begin
    if(clk'event and clk='1') then
      if(rst='1') then
        dout<=(others=>'0');
      else
        dout<=din;
      end if;
    end if;
  end process U_clk;

end behavior;
