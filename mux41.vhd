library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux41 is
generic(n:integer:=8);
port (dina    : in std_logic_vector(n-1 downto 0);
      dinb    : in std_logic_vector(n-1 downto 0);
      dinc    : in std_logic_vector(n-1 downto 0);
      dind    : in std_logic_vector(n-1 downto 0);
      sel     : in std_logic_vector(1 downto 0);
      dout    : out std_logic_vector(n-1 downto 0));
end entity mux41;

architecture struct of mux41 is
begin
dout<=dina when sel="00" else
      dinb when sel="01" else
      dinc when sel="10" else
      dind when sel="11";
end struct;
