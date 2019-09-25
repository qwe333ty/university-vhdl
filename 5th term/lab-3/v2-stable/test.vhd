library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity test_entity is
end test_entity;

architecture test_architecture of test_entity is
    constant N : natural := 4;

    component schema
        generic(N : natural := 4);
        port(r, s : in bit_vector(N - 1 downto 0);
             t : out bit_vector((2 * N) - 1 downto 0));
    end component;

    signal r, s : bit_vector(3 downto 0);
    signal t : bit_vector(7 downto 0);

    begin
        schema_label: schema generic map(N => N) 
                             port map(r => r,
                                      s => s,
                                      t => t);
        
        r <= "0000",
             "0001" after 100 ns,
             "0010" after 200 ns,
             "0011" after 400 ns,
             "0100" after 500 ns,
             "0101" after 700 ns,
             "0110" after 900 ns,
             "0111" after 1100 ns,
             "1000" after 1300 ns,
	         "1011" after 1500 ns; 
        s <= "0000",
             "0001" after 100 ns,
             "0010" after 200 ns,
             "0011" after 300 ns,
             "0100" after 600 ns,
             "0101" after 800 ns,
             "0110" after 1000 ns,
             "0111" after 1200 ns,
             "1000" after 1400 ns;

end test_architecture;