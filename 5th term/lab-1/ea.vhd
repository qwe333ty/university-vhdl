library ieee;
use ieee.std_logic_1164.all;


entity first_entity is
    port(x1, x2, x3, x4 : in bit;
         y1, y2, y3 : out bit);
end first_entity;

architecture first_architecture of first_entity is
    begin
        y1 <= ((not x1) and x2 and x3 and (not x4)) or
              (x1 and (not x2) and x3 and x4);

        y2 <= not(x1 and (not x2) and (not x3) and x4);

        y3 <= not(
            ((not x1) and x2 and x4) or
            (x2 and x3 and x4) or
            (not(x2 or x3 or x4)) or
            (x1 and not(x2 or x4))
        );

end first_architecture;