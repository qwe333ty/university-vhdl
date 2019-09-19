library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity and_operator is
    port(a, b : in bit;
         y : out bit);
end and_operator;

architecture and_operator_behaviour of and_operator is
    begin
        y <= (a and b);
end and_operator_behaviour;