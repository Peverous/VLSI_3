library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_arbiter_1 is
port (clk   : in std_logic;
      rst   : in std_logic;
      r1    : in std_logic;
      r0    : in std_logic;
      g1    : out std_logic;
      g0    : out std_logic);
end entity FSM_arbiter_1;

architecture fsm of FSM_arbiter_1 is
type state is (waitr,grand0,grand1);
signal g1_i         : std_logic;
signal g0_i         : std_logic;
signal next_st8     : state;
signal current_st8  : state;

begin
U_clk : process(clk)
begin
  if (clk'event and clk='1') then
    if (rst='1') then
      g0            <='0';
      g1            <='0';
      current_st8   <=waitr;
    else
      g0            <=g0_i;
      g1            <=g1_i;
      current_st8   <=next_st8;
    end if;
  end if;
end process U_clk;

U_output  : process(current_st8)
begin
  if (current_st8=waitr) then
    g0_i            <='0';
    g1_i            <='0';

  elsif (current_st8=grand0) then
    g0_i            <='1';
    g1_i            <='0';

  elsif (current_st8=grand1) then
    g0_i            <='0';
    g1_i            <='1';

  else
    g0_i            <='0';
    g1_i            <='0';
  end if;
end process U_output;

U_next_state  : process(r0,r1,current_st8)
begin
  case(current_st8) is
    when waitr =>
      if (r0='1' and r1='0') then
        next_st8      <= grand0;
      elsif (r0='0' and r1='1') then
        next_st8      <=grand1;
      elsif (r0='1' and r1='1') then
        next_st8      <=grand1;
      else
        next_st8      <=waitr;
      end if;

    when grand0 =>
      if (r0='1') then
        next_st8      <=grand0;
      else
        next_st8      <=waitr;
      end if;

    when grand1 =>
      if (r1='1') then
        next_st8      <=grand1;
      else
        next_st8      <=waitr;
      end if;

    when others =>
      next_st8        <=waitr;
  end case;
end process U_next_state;
end fsm;
