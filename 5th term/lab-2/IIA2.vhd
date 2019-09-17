library ieee;
use ieee.std_logic_1164.all;


-- AND with inverse inputs
entity IIA2 is
    port(a, b : in bit;
         y : out bit);
end IIA2;

architecture IIA2_behaviour of IIA2 is
    begin
        y <= ((not a) and (not b)) after 3 ns;
end IIA2_behaviour;