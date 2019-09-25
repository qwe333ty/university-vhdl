library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity multiplication_stage is
    generic(N : natural := 4);
    port(r : in bit;
         s, prev_stage_sums : in bit_vector(N - 1 downto 0);
         current_stage_sums : out bit_vector(N - 1 downto 0);
         out_t : out bit);
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

    signal and_results : bit_vector(N - 1 downto 0);
    signal carry_results : bit_vector(N - 2 downto 0);

    begin
        horizontal_direction: for horizontal_index in 0 to N - 1 generate
            zero_index: if horizontal_index = 0 generate
                calculate_and: and_operator port map(a => r,
                                                     b => s(horizontal_index),
                                                     y => and_results(horizontal_index));
                                                     
                sum_values: half_adder port map(b1 => and_results(horizontal_index),
                                                b2 => prev_stage_sums(horizontal_index),
                                                c1 => carry_results(horizontal_index),
                                                s1 => out_t);
            end generate zero_index;

            middle_index: if horizontal_index > 0 and horizontal_index < N - 1 generate
                calculate_and: and_operator port map(a => r,
                                                     b => s(horizontal_index),
                                                     y => and_results(horizontal_index));

                sum_values: full_adder port map(b1 => carry_results(horizontal_index - 1),
                                                b2 => and_results(horizontal_index),
                                                b3 => prev_stage_sums(horizontal_index),
                                                c1 => carry_results(horizontal_index),
                                                s1 => current_stage_sums(horizontal_index - 1));
            end generate middle_index;

            last_index: if horizontal_index = N - 1 generate
                calculate_and: and_operator port map(a => r,
                                                     b => s(horizontal_index),
                                                     y => and_results(horizontal_index));
                                                     
                sum_values: full_adder port map(b1 => carry_results(horizontal_index - 1),
                                                b2 => and_results(horizontal_index),
                                                b3 => prev_stage_sums(horizontal_index),
                                                c1 => current_stage_sums(horizontal_index),
                                                s1 => current_stage_sums(horizontal_index - 1));
            end generate last_index;
        end generate horizontal_direction;
end multiplication_stage_behaviour; 