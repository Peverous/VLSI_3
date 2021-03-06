library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO is
generic (data_width: integer:=8);
port (clk       : in std_logic;
      rst       : in std_logic;
      wr        : in std_logic;
      rd        : in std_logic;
      fifo_din  : in std_logic_vector(data_width-1 downto 0);
      full      : out std_logic;
      empty     : out std_logic;
      fifo_dout : out std_logic_vector(data_width-1 downto 0));
end entity FIFO;

architecture struct_fifo of FIFO is

component fifo_controller is
port (clk     : in std_logic;
      rst     : in std_logic;
      wr      : in std_logic;
      rd      : in std_logic;
      full    : out std_logic;
      empty   : out std_logic;
      w_addr  : out std_logic_vector(3 downto 0);
      r_addr  : out std_logic_vector(3 downto 0));
end component fifo_controller;

component ram is
generic (depth: integer:=16;
         width: integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      w_en    : in std_logic;
      w_addr: in std_logic_vector(3 downto 0);
      r_addr: in std_logic_vector(3 downto 0);
      w_data   : in std_logic_vector(width-1 downto 0);
      r_data  : out std_logic_vector(width-1 downto 0));
end component ram;


signal w_en   : std_logic;
signal full_s : std_logic;
signal w_address     : std_logic_vector(3 downto 0);
signal r_address     : std_logic_vector(3 downto 0);

begin
w_en<=wr and (not full_s);
full<=full_s;

U_RAM : ram generic map (depth=>16,width=>data_width)
                 port map (clk=>clk,
                           rst=>rst,
                           w_en=>w_en,
                           w_addr=>w_address,
                           r_addr=>r_address,
                           w_data=>fifo_din,
                           r_data=>fifo_dout);

U_CONTROLLER : fifo_controller
                              port map (clk=>clk,
                                        rst=>rst,
                                        wr=>wr,
                                        rd=>rd,
                                        full=>full_s,
                                        empty=>empty,
                                        w_addr=>w_address,
                                        r_addr=>r_address);

end struct_fifo;
