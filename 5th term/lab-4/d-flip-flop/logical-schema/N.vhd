library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity N is
    port (x : in std_logic;
          y : out std_logic);
end N;

architecture N_behaviour of N is
    begin
        y <= (not x) after 2 ns;
end N_behaviour;