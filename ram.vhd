library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
generic (depth: integer:=16;
         width: integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      w_en    : in std_logic;
      w_addr: in std_logic_vector(3 downto 0);
      r_addr: in std_logic_vector(3 downto 0);
      w_data   : in std_logic_vector(width-1 downto 0);
      r_data  : out std_logic_vector(width-1 downto 0));
end entity ram;

architecture struct of ram is
constant zeros  : std_logic_vector(depth-1 downto 0):=(others=>'0');
type rf is array (depth-1 downto 0) of std_logic_vector(width-1 downto 0);
signal regfile : rf;

begin
U_ram : process(clk)
  begin
    if (clk'event and clk='1') then
      if(rst='1') then
        regfile <=(others=>(others=>'0'));
      else
        if (w_en='1') then
          regfile(to_integer(unsigned(w_addr)))<=w_data;
        end if;
        r_data<=regfile(to_integer(unsigned(r_addr)));
      end if;
    end if;
  end process U_ram;

end struct;
