library ieee;
use ieee.std_logic_1164.all;


entity test_schema is
end test_schema;

architecture test_architecture of test_schema is
    component decoder_schema
    port(C : in bit_vector(0 to 1);
         D : in bit_vector(3 downto 0);
         Y : out bit_vector(0 to 15));
    end component;

    signal C_test : bit_vector(0 to 1);
    signal D_test : bit_vector(0 to 3);
    signal Y_test : bit_vector(0 to 15);

    begin
        first_test: decoder_schema port map(C => C_test, 
                                            D => D_test, Y => Y_test);
                    
                    C_test <= "00";

                    D_test <= "0000",
                              "0001" after 100 ns,
                              "0010" after 200 ns,
                              "0011" after 300 ns,

                              "0100" after 400 ns,
                              "0101" after 500 ns,
                              "0110" after 600 ns,
                              "0111" after 700 ns,

                              "1000" after 800 ns,
                              "1001" after 900 ns,
                              "1010" after 1000 ns,
                              "1011" after 1100 ns,

                              "1100" after 1200 ns,
                              "1101" after 1300 ns,
                              "1110" after 1400 ns,
                              "1111" after 1500 ns;
                              
end test_architecture;