library ieee;
use ieee.std_logic_1164.all;


entity test_first_entity is
end test_first_entity;

architecture test_architecture of test_first_entity is
    component first_entity port(x1, x2, x3, x4 : in bit;
                                y1, y2, y3 : out bit);
    end component;
    
    signal x1, x2, x3, x4, y1, y2, y3 : bit;

    begin
        p1: first_entity port map (x1 => x1, x2 => x2, x3 => x3,
                                   x4 => x4, y1 => y1, y2 => y2,
                                   y3 => y3);

            x1 <= '0', '1' after 800 ns;

            x2 <= '0', '1' after 400 ns, '0' after 800 ns,
                  '1' after 1200 ns;

            x3 <= '0', '1' after 200 ns, '0' after 400 ns,
                  '1' after 600 ns, '0' after 800 ns,
                  '1' after 1000 ns, '0' after 1200 ns,
                  '1' after 1400 ns;

            x4 <= '0', '1' after 100 ns, '0' after 200 ns,
                  '1' after 300 ns, '0' after 400 ns,
                  '1' after 500 ns, '0' after 600 ns,
                  '1' after 700 ns, '0' after 800 ns,
                  '1' after 900 ns, '0' after 1000 ns,
                  '1' after 1100 ns, '0' after 1200 ns,
                  '1' after 1300 ns, '0' after 1400 ns,
                  '1' after 1500 ns;

end test_architecture;