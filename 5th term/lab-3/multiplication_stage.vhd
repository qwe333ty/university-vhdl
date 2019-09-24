library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity multiplication_stage is
    generic(N : natural := 4);
    port(r : in bit;
         s : in bit_vector(0 to N - 1);
         intermediate_result : in bit_vector(0 to N - 1);
         result : out bit_vector(0 to N - 1);
         t : out bit);
end multiplication_stage;

architecture multiplication_stage_behaviour of multiplication_stage is
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

    signal temp_vector : bit_vector(0 to N - 1);
    signal adder_transfer_bits : bit_vector(0 to N - 1);

    begin
        horizontal_direction: for horizontal_index in 0 to N - 1 generate

            zero_index: if horizontal_index = 0 generate
                and_operator_label: and_operator port map(a => r,
                                                      b => s(horizontal_index),
                                                      y => temp_vector(horizontal_index));
                half_adder_0: half_adder port map(b1 => temp_vector(horizontal_index),
                                                  b2 => intermediate_result(horizontal_index),
                                                  c1 => adder_transfer_bits(horizontal_index),
                                                  s1 => t);
            end generate zero_index;

            middle_index: if horizontal_index > 0 and horizontal_index < N generate
                and_operator_label: and_operator port map(a => r,
                                                      b => s(horizontal_index),
                                                      y => temp_vector(horizontal_index));
                full_adder_middle: full_adder port map(b1 => adder_transfer_bits(horizontal_index - 1),
                                                       b2 => temp_vector(horizontal_index),
                                                       b3 => intermediate_result(horizontal_index - 1),
                                                       c1 => adder_transfer_bits(horizontal_index),
                                                       s1 => result(horizontal_index - 1));
                inner_if: if horizontal_index = N - 1 generate
                    result(horizontal_index) <= adder_transfer_bits(horizontal_index);
                end generate inner_if;
            end generate middle_index;
        end generate horizontal_direction;
end multiplication_stage_behaviour;               
