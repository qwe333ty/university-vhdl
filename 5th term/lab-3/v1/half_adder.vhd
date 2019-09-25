library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity half_adder is
    port(b1, b2 : in bit;
         c1, s1 : out bit);
end half_adder;

architecture half_adder_behaviour of half_adder is
    begin
        c1 <= (b1 and b2);
        s1 <= (b1 xor b2);
end half_adder_behaviour;