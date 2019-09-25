library ieee;
use ieee.std_logic_1164.all;

-- Aliksandr Rahavoi
entity schema is
    generic(N : natural := 4);
    port(r, s : in bit_vector(N - 1 downto 0);
         t : out bit_vector((2 * N) - 1 downto 0));
end schema;

architecture schema_behaviour of schema is
    component multiplication_stage
        generic(N : natural := 4);
        port(r : in bit;
             s, prev_stage_sums : in bit_vector(N - 1 downto 0);
             current_stage_sums : out bit_vector(N - 1 downto 0);
             out_t : out bit);
    end component;

    -- New type: matrix - array where element is bit_vector.
    type matrix is array(natural range<>) of bit_vector(N - 1 downto 0);

    signal prev_stage_sums_array : matrix(N - 1 downto 0);
    signal current_stage_sums_array : matrix(N - 1 downto 0);

    begin
        vertical_direction: for vertical_index in 0 to N - 1 generate
            update_result: if vertical_index < N - 1 generate
                stage: multiplication_stage generic map(N => N)
                        port map(r => r(vertical_index),
                                 s => s,
                                 prev_stage_sums => prev_stage_sums_array(vertical_index),
                                 current_stage_sums => current_stage_sums_array(vertical_index),
                                 out_t => t(vertical_index));

                prev_stage_sums_array(vertical_index + 1) <= current_stage_sums_array(vertical_index);
            end generate update_result;

            last_element: if vertical_index = N - 1 generate
                stage: multiplication_stage generic map(N => N)
                        port map(r => r(vertical_index),
                                 s => s,
                                 prev_stage_sums => prev_stage_sums_array(vertical_index),
                                 current_stage_sums => current_stage_sums_array(vertical_index),
                                 out_t => t(vertical_index));
                t((2 * N) - 1 downto N) <= current_stage_sums_array(vertical_index)(N - 1 downto 0);
            end generate last_element;
        end generate vertical_direction;
end schema_behaviour;