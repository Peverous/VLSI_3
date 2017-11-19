library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file_tb is
end reg_file_tb;

architecture tester of reg_file_tb is

component new_reg_file is
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
end component new_reg_file;


signal clk      : std_logic;
signal rst      : std_logic;
signal period   : time:=50 ns;
signal wr_en	: std_logic;
signal din_addr	: std_logic_vector(1 downto 0);
signal din 		: std_logic_vector(15 downto 0);
signal dout0_addr   : std_logic_vector(1 downto 0);
signal dout1_addr   : std_logic_vector(1 downto 0);
signal dout0    : std_logic_vector(15 downto 0);
signal dout1    : std_logic_vector(15 downto 0);

begin

UUT : new_reg_file generic map(n=>16,
                                len_addr=>2)
port map (clk=>clk,
            rst=>rst,
            wr_en=>wr_en,
            w_addr=>din_addr,
            w_data=>din,
            r_addr0=>dout0_addr,
            r_addr1=>dout1_addr,
            r_data0=>dout0,
            r_data1=>dout1);

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
wr_en<='0';
din<=(others=>'1');
din_addr<="10";
dout0_addr<="00";
dout1_addr<="01";

wait for 2*period;
rst<='0';
wait for period;

wr_en<='1';
wait for period;
wr_en<='0';
dout0_addr<="10";
dout1_addr<="00";
wait for period;
end process;

end tester;


