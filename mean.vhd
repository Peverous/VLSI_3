library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mean is
  generic(n:integer:=8;
          m:integer:=3);
  port(clk    : in std_logic;
       rst    : in std_logic;
       din    : in std_logic_vector(n-1 downto 0);
       mean_val: out std_logic_vector(n-1 downto 0));
end mean;

architecture struct of mean is
  component reg is
    generic(n:integer:=8);
    port(clk  : in std_logic;
         rst  : in std_logic;
         din  : in std_logic_vector(n-1 downto 0);
         dout : out std_logic_vector(n-1 downto 0));
  end component reg;

  component counter is
    generic(n:integer:=3);
    port(clk  : in std_logic;
         rst  : in std_logic;
         dout : out std_logic_vector(n-1 downto 0));
  end component counter;

  component reg_en is
    generic(n:integer:=8);
    port(clk  : in std_logic;
         rst  : in std_logic;
         en   : in std_logic;
         din  : in std_logic_vector(n-1 downto 0);
         dout : out std_logic_vector(n-1 downto 0));
    end component reg_en;

  signal new_data   : std_logic_vector(2*n-1 downto 0);
  signal old_data   : std_logic_vector(2*n-1 downto 0);
  signal sum        : std_logic_vector(2*n-1 downto 0);
  signal rst_old    : std_logic;
  signal en_out     : std_logic;
  signal cnt        : std_logic_vector(m-1 downto 0);
  signal tmp_mean   : std_logic_vector(2*n-1 downto 0);
  signal tmp_data   : std_logic_vector(n-1 downto 0);
  
begin
  en_out<=( cnt(m-3)) and cnt(m-2) and cnt(m-1); --num=6;
  rst_old<=(( cnt(m-3)) and cnt(m-2) and cnt(m-1))or rst;
  new_data<="00000000"&din;
  --new_data<="00000000"&tmp_data;
  sum<=std_logic_vector(unsigned(new_data)+unsigned(old_data));
  tmp_mean<=to_stdlogicvector(to_bitvector(sum) srl 3);

--  U_in : reg generic map (n=>n)
--    port map (clk=>clk,
--              rst=>rst,
--              din=>din,
--              dout=>tmp_data);

  U_old : reg generic map(n=>2*n)
    port map(clk=>clk,
             rst=>rst_old,
             din=>sum,
             dout=>old_data);

  U_cnt : counter generic map(n=>m)
    port map(clk=>clk,
             rst=>rst,
             dout=>cnt);

  U_out : reg_en generic map(n=>n)
    port map(clk=>clk,
             rst=>rst,
             en=>en_out,
             din=>tmp_mean(n-1 downto 0),
             dout=>mean_val);


end struct;

