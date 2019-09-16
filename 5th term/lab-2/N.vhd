library ieee;
use ieee.std_logic_1164.all;


entity N is
    port(x : in bit;
         y : out bit);
end N;

architecture n_behaviour of N is
    begin
        y <= (not x);
end n_behaviour;