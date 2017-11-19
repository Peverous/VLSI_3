library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity new_reg_file is
generic (n:integer:=16;
    len_addr:integer:=2);
port(clk    : in std_logic;
    rst     : in std_logic;
    wr_en   : in std_logic;
    w_addr  : in std_logic_vector(len_addr-1 downto 0);
    r_addr0 : in std_logic_vector(len_addr-1 downto 0);
    r_addr1 : in std_logic_vector(len_addr-1 downto 0);
    w_data  : in std_logic_vector(n-1 downto 0);
    r_data0 : out std_logic_vector(n-1 downto 0);
    r_data1 : out std_logic_vector(n-1 downto 0));
end new_reg_file;

architecture behavior of new_reg_file is

type arr is array (2**(len_addr)-1 downto 0) of std_logic_vector(n-1 downto 0);

signal reg_file : arr;
signal din      : std_logic_vector(n-1 downto 0);
signal dout1    : std_logic_vector(n-1 downto 0);
signal dout2    : std_logic_vector(n-1 downto 0);
begin

U_clk : process(clk,rst)
begin
    if(rst='1') then
        reg_file<=(others=>(others=>'0'));
    elsif(clk'event and clk='1') then
        if(wr_en='1') then
            reg_file(to_integer(unsigned(w_addr)))<=w_data;
        else
            r_data0<=reg_file(to_integer(unsigned(r_addr0)));
            r_data1<=reg_file(to_integer(unsigned(r_addr1)));
        end if;
    end if;
end process U_clk;

end behavior;
