library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
generic(n:integer:=8);
port (clk     : in std_logic;
      rst     : in std_logic;
      we      : in std_logic;
      w_addr  : in std_logic_vector(1 downto 0);
      r_addr0 : in std_logic_vector(1 downto 0);
      r_addr1 : in std_logic_vector(1 downto 0);
      w_data  : in std_logic_vector(n-1 downto 0);
      r_data0 : out std_logic_vector(n-1 downto 0);
      r_data1 : out std_logic_vector(n-1 downto 0));
end entity register_file;

architecture structural of register_file is
signal

component registerN is
generic (n: integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      we    : in std_logic;
      din   : in std_logic_vector(n-1 downto 0);
      dout  : out std_logic_vector(n-1 downto 0));
end component registerN;
begin
U_DEMUX : demux port
