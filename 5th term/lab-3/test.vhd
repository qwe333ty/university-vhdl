library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity test_entity is
end test_entity;

architecture test_architecture of test_entity is
    constant N : natural := 4;

    component schema
        generic (N : natural);
        port(r, s : in bit_vector(0 to N - 1);
             t : out bit_vector((2 * N) - 1) downto 0);
    end component;

    signal r, s : bit_vector(0 to 3);
    signal t : bit_vector(0 to 7);

    begin
        schema_label: schema generic map(N => N) 
                             port map(r => r,
                                      s => s,
                                      t => t);
        
        r <= "0000",
             "0001" after 100 ns,
             "0010" after 200 ns;
        s <= "0000",
             "0001" after 100 ns,
             "0010" after 200 ns,
             "0011" after 300 ns;                              

end test_architecture;