library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_controller is
port (clk     : in std_logic;
      rst     : in std_logic;
      wr      : in std_logic;
      rd      : in std_logic;
      full    : out std_logic;
      empty   : out std_logic;
      w_addr  : out std_logic_vector(3 downto 0);
      r_addr  : out std_logic_vector(3 downto 0));
end entity fifo_controller;

architecture behavior of fifo_controller is
signal rd_ptr	: std_logic_vector(3 downto 0);
signal wr_ptr	: std_logic_vector(3 downto 0);

component counter is
generic (n:integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      en    : in std_logic;
      dout  : out std_logic_vector(n-1 downto 0));
end component counter;

begin
U_WRPTR : counter generic map (n=>4)
                  port map (clk=>clk,
                            rst=>rst,
                            en=>wr,
                            dout=>wr_ptr);

U_RDPTR : counter generic map (n=>4)
                  port map (clk=>clk,
                            rst=>rst,
                            en=>rd,
                            dout=>rd_ptr);


U_proc : process(rd,wr,wr_ptr,rd_ptr)
  begin
    if(wr_ptr=rd_ptr) then
      full<='0';
      empty<='1';
    elsif(unsigned(wr_ptr)=unsigned(rd_ptr)-1) then
      full<='1';
      empty<='0';
    else
      full<='0';
      empty<='0';
    end if;
  end process U_proc;

w_addr<=wr_ptr;
r_addr<=rd_ptr;

end behavior;
