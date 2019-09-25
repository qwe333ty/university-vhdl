library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity schema is
    generic (N : natural := 4);
    port(r, s : in bit_vector(0 to N - 1);
         t : out bit_vector((2 * N) - 1) downto 0);
end schema;

architecture schema_behaviour of schema is
    component multiplication_stage
	generic(N : natural := 4);
        port(r : in bit;
             s : in bit_vector(0 to N - 1);
             intermediate_result : in bit_vector(0 to N - 1);
             result : out bit_vector(0 to N - 1);
             t : out bit);
    end component;

    type matrix is array(natural range<>) of bit_vector(0 to N - 1);
    signal temp_result : matrix(0 to N - 1);
    signal intermediate_result : matrix(0 to N - 1);

    begin
        vertical_direction: for vertical_index in 0 to N - 1 generate
            update_result: if vertical_index < N - 1 generate
                stage: multiplication_stage generic map(N => N) 
                        port map(r => r(vertical_index),
                                 s => s,
                                 intermediate_result => intermediate_result(vertical_index),
                                 result => temp_result(vertical_index),
                                 t => t(vertical_index));

                intermediate_result(vertical_index + 1) <= temp_result(vertical_index);
            end generate update_result;

            last_element: if vertical_index = N - 1 generate
                stage: multiplication_stage generic map(N => N) 
                    port map(r => r(vertical_index),
                             s => s,
                             intermediate_result => intermediate_result(vertical_index),
                             result => temp_result(vertical_index),
                             t => t(vertical_index));
                inner_for: for temp_index in 1 to N - 1 generate
                    t(vertical_index + temp_index) <= temp_result(vertical_index)(temp_index - 1);
                end generate inner_for; 
            end generate last_element;
        end generate vertical_direction;
end schema_behaviour; 
