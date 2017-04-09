library ieee;
use ieee.std_Logic_1164.all;
use ieee.numeric_std.all;

entity modulo10 is
port (clk   : in std_logic;
      rst   : in std_logic;
      en    : in std_logic;
      en_nxt: out std_logic;
      dout  : out std_logic_vector(3 downto 0));
end modulo10;

architecture behavior of modulo10 is
constant max_bcd  : std_logic_vector(3 downto 0):="1001";
signal tmp        : std_logic_vector(3 downto 0);
signal clear      : std_logic;

begin


U_clk : process(clk)
 begin
  if (clk'event and clk='1') then
    if (rst='1' or clear='1') then
      tmp<=(others=>'0');
    else
      if (en='1') then
        tmp<=std_logic_vector(unsigned(tmp)+1);
      else
        tmp<=tmp;
      end if;
    end if;
  end if;
end process U_clk;

U_proc : process(tmp)
  begin
    if (tmp=max_bcd) then
      en_nxt<='1';
      clear<='1';
    else
      en_nxt<='0';
      clear<='0';
    end if;
  end process U_proc;

dout<=tmp;

end behavior;
