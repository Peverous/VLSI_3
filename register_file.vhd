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

component registerN is
generic (n: integer:=8);
port (clk   : in std_logic;
      rst   : in std_logic;
      we    : in std_logic;
      din   : in std_logic_vector(n-1 downto 0);
      dout  : out std_logic_vector(n-1 downto 0));
end component registerN;

component  demux is
generic (n:integer:=8);
port (din   : in std_logic_vector(n-1 downto 0);
      sel   : in std_logic_vector(1 downto 0);
      douta : out std_logic_vector(n-1 downto 0);
      doutb : out std_logic_vector(n-1 downto 0);
      doutc : out std_logic_vector(n-1 downto 0);
      doutd : out std_logic_vector(n-1 downto 0));
end component demux;

component mux41 is
generic(n:integer:=8);
port (dina    : in std_logic_vector(n-1 downto 0);
      dinb    : in std_logic_vector(n-1 downto 0);
      dinc    : in std_logic_vector(n-1 downto 0);
      dind    : in std_logic_vector(n-1 downto 0);
      sel     : in std_logic_vector(1 downto 0);
      dout    : out std_logic_vector(n-1 downto 0));
end component mux41;

signal d1,d2,d3,d4 : std_logic_vector(n-1 downto 0);
signal q1,q2,q3,q4 : std_logic_vector(n-1 downto 0);

begin
U_DEMUX : demux generic map (n=>n)
                port map (din=>w_data,
                          sel=>w_addr,
                          douta=>d1,
                          doutb=>d2,
                          doutc=>d3,
                          doutd=>d4);

  U_REG1 : registerN generic map(n=>n)
                            port map (clk=>clk,
                                      rst=>rst,
                                      we=>we,
                                      din=>d1,
                                      dout=>q1);

  U_REG2 : registerN generic map(n=>n)
                     port map (clk=>clk,
                               rst=>rst,
                               we=>we,
                               din=>d2,
                               dout=>q2);

  U_REG3 : registerN generic map(n=>n)
                     port map (clk=>clk,
                               rst=>rst,
                               we=>we,
                               din=>d3,
                               dout=>q3);

  U_REG4 : registerN generic map(n=>n)
                     port map (clk=>clk,
                               rst=>rst,
                               we=>we,
                               din=>d4,
                               dout=>q4);

  U_MUX1 : mux41 generic map(n=>n)
                 port map (dina=>q1,
                           dinb=>q2,
                           dinc=>q3,
                           dind=>q4,
                           sel=>r_addr0,
                           dout=>r_data0);

  U_MUX2 : mux41 generic map (n=>n)
                 port map (dina=>q1,
                           dinb=>q2,
                           dinc=>q3,
                           dind=>q4,
                           sel=>r_addr1,
                           dout=>r_data1);

end structural;