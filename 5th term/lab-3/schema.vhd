library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity schema is
    generic (N : natural := 4);
    port(s, r : in bit_vector(0 to N - 1);
         t : out bit_vector(0 to (2 * N) - 1));
end schema;

architecture schema_behaviour of schema is
    component and_operator
    port(a, b : in bit;
         y : out bit);
    end component;

    component half_adder
    port(b1, b2 : in bit;
         c1, s1 : out bit);
    end component;

    component full_adder
    --   P   A   B
    port(b1, b2, b3 : in bit;
         c1, s1 : out bit);
    end component;

    signal intermediate_bit_supplier : bit_vector(1 to N - 1);
    signal temp_bit_supplier, temp_c_supplier, temp_c_supplier_1 : bit;

    begin
        vertical_direction: for vertical_index in 0 to N - 1 generate
            first_vertical_line: if (vertical_index = 0) generate
                inner_horizontal_direction_0: for horizontal_index in 0 to N - 1 generate
                    zero_case_0: if horizontal_index = 0 generate
                        zero_and_0: and_operator port map(a => r(vertical_index), 
                                                        b => s(horizontal_index),
                                                        y => t(vertical_index));
                    end generate zero_case_0;

                    another_case_0: if (horizontal_index > 0) and (horizontal_index < N) generate
                        next_and_0: and_operator port map(a => r(vertical_index),
                                                        b => s(horizontal_index),
                                                        y => intermediate_bit_supplier(horizontal_index));
                    end generate another_case_0;
                end generate inner_horizontal_direction_0;
            end generate first_vertical_line;
            
            middle_vertical_line: if (vertical_index > 0) and (vertical_index < N - 1) generate
                inner_horizontal_direction_1: for horizontal_index in 0 to N - 1 generate
                    zero_case_1: if horizontal_index = 0 generate
                        zero_and_1: and_operator port map(a => r(vertical_index), 
                                                        b => s(horizontal_index),
                                                        y => temp_bit_supplier);
                        add_1: half_adder port map(b1 => temp_bit_supplier, -- maybe it's corner case. ask a question!!!
                                                   b2 => intermediate_bit_supplier(horizontal_index + 1),
                                                   c1 => temp_c_supplier,
                                                   s1 => t(vertical_index));
                    end generate zero_case_1;

                    middle_case_1: if (horizontal_index > 0) and (horizontal_index < N) generate
                        next_and_1: and_operator port map(a => r(vertical_index),
                                                        b => s(horizontal_index),
                                                        y => temp_bit_supplier);
                        add_2: full_adder port map(b1 => temp_c_supplier,
                                                   b2 => temp_bit_supplier, -- maybe it's corner case. ask a question!!!
                                                   b3 => intermediate_bit_supplier(horizontal_index + 1),
                                                   c1 => temp_c_supplier,
                                                   s1 => intermediate_bit_supplier(horizontal_index));
                    end generate middle_case_1;

                    end_case_1: if horizontal_index = N - 1 generate
                        zero_and_1: and_operator port map(a => r(vertical_index), 
                                                          b => s(horizontal_index),
                                                          y => temp_bit_supplier);
                        add_1: half_adder port map(b1 => temp_bit_supplier, -- maybe it's corner case. ask a question!!!
                                                   b2 => intermediate_bit_supplier(horizontal_index + 1),
                                                   c1 => temp_c_supplier,
                                                   s1 => t(vertical_index));
                    end generate end_case_1;
                end generate inner_horizontal_direction_1;
            end generate middle_vertical_line;

            --
        end generate vertical_direction;
end schema_behaviour; 
