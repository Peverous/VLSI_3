library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux is
generic (n:integer:=8);
port (din   : in std_logic_vector(n-1 downto 0);
      sel   : in std_logic_vector(1 downto 0);
      douta : out std_logic_vector(n-1 downto 0);
      doutb : out std_logic_vector(n-1 downto 0);
      doutc : out std_logic_vector(n-1 downto 0);
      doutd : out std_logic_vector(n-1 downto 0));
end entity demux;

architecture behavioral of demux is
signal tmp  : std_logic_vector(n-1 downto 0);
begin
U_proc : process(din,sel)
begin
  if (sel="00") then
    douta<=din;
  elsif (sel="01") then
    doutb<=din;
  elsif (sel="10") then
    doutc<=din;
  else
    doutd<=din;
  end if;
end process U_proc;
end behavioral;
