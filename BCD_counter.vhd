library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD_counter is
port (clk   : in std_logic;
      rst   : in std_logic;
      en    : in std_logic;
      ovflow: out std_logic;
      dout0 : out std_logic_vector(3 downto 0);
      dout1 : out std_logic_vector(3 downto 0);
      dout2 : out std_logic_vector(3 downto 0));
end BCD_counter;

architecture struct of BCD_counter is
signal en_in_0 : std_logic;
signal en_in_1 : std_logic;
signal en_in_2 : std_logic;

component  modulo10 is
port (clk   : in std_logic;
      rst   : in std_logic;
      en    : in std_logic;
      en_nxt: out std_logic;
      dout  : out std_logic_vector(3 downto 0));
end component modulo10;

begin
U_MOD10_0 : modulo10 port map (clk=>clk,
                      rst=>rst,
                      en=>en,
                      en_nxt=>en_in_0,
                      dout=>dout0);

U_MOD10_1 : modulo10 port map (clk=>clk,
                      rst=>rst,
                      en=>en_in_0,
                      en_nxt=>en_in_1,
                      dout=>dout1);

U_MOD10_2 : modulo10 port map (clk=>clk,
                      rst=>rst,
                      en=>en_in_1,
                      en_nxt=>ovflow,
                      dout=>dout2);

end struct;
