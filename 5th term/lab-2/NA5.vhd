library ieee;
use ieee.std_logic_1164.all;


entity NA5 is
    port(a, b, c, d, control : in bit;
         y : out bit);
end NA5;

architecture NA5_behaviour of NA5 is
    begin
        y <= not(a and b and c and d and control) after 5 ns;
end NA5_behaviour;