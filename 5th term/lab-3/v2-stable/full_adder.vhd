library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity full_adder is
    --   P   A   B
    port(b1, b2, b3 : in bit;
         c1, s1 : out bit);
end full_adder;

architecture full_adder_behaviour of full_adder is
    begin
        c1 <= (b2 and b3) or (b1 and b2) or (b1 and b3);
        s1 <= (b1 xor b2 xor b3);
end full_adder_behaviour;