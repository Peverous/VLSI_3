library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_diafora is
generic (n:integer:=8);
port (a	: in std_logic_vector(n-1 downto 0);
      b : in std_logic_vector(n-1 downto 0);
      y : out std_logic_vector(n-1 downto 0);
      x : out std_logic_vector(n-1 downto 0));
end entity abs_diafora;

architecture behavioral of abs_diafora is
signal diafora : std_logic_vector(n-1 downto 0);

begin
diafora<= std_logic_vector(unsigned(a) - unsigned(b));
x<=diafora when diafora(n-1)='0' else  std_logic_vector(unsigned(not diafora)+1);

--or else more efficient
y<=std_logic_vector(abs(signed(a) - signed(b)) );
end behavioral;