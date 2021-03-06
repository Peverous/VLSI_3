library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_bin_cnt is
generic (n:integer:=8);
port (clk   : in std_logic;
      reset : in std_logic;
      clear : in std_logic;
      load  : in std_logic;
      en    : in std_logic;
      up    : in std_logic;
      d     : in std_logic_vector(n-1 downto 0);
      Q     : out std_logic_vector(n-1 downto 0);
      min   : out std_logic;
      max   : out std_logic);
end entity uni_bin_cnt;

architecture behavior of uni_bin_cnt is
constant max_val  : std_logic_vector(n-1 downto 0):=(others=>'1');
constant min_val  : std_logic_vector(n-1 downto 0):=(others=>'0');
signal tmp    : std_logic_vector(n-1 downto 0);

begin
U_clk : process(clk,reset)
  begin
    if (reset='1') then
      tmp<=(others=>'0');
    else
      if (clk'event and clk='1') then
        if (clear='1') then
          tmp<=(others=>'0');
        else
          if (load='1') then
            tmp<=d;
          else
            if (en='1' and up='1') then
              tmp<=std_logic_vector(unsigned(tmp)+1);
            elsif (en='1' and up='0') then
              tmp<= std_logic_vector(unsigned(tmp)-1);
            else
              tmp<=tmp;
            end if;
          end if;
        end if;
      end if;
    end if;
  end process U_clk;

 Q<=tmp;

U_proc  : process(tmp)
    begin
    if (tmp=max_val) then
      max<='1';
      min<='0';
    elsif (tmp=min_val) then
      max<='0';
      min<='1';
    else
      max<='0';
      min<='0';
    end if;
  end process U_proc;

  end behavior;
