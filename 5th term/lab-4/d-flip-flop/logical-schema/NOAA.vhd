library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity NOAA is
    port (x : in std_logic_vector(0 to 3);
          y : out std_logic);
end NOAA;

architecture NOAA_behaviour of NOAA is
    begin
        y <= ((x(0) and x(1)) nor (x(2) and x(3))) after 5 ns;
end NOAA_behaviour;