library ieee;
use ieee.std_logic_1164.all;

-- Aliaksandr Rahavoi
entity schema is
    port(d, clk, ti, te : in std_logic;
         qn : out std_logic);
end schema;

architecture schema_behaviour of schema is
    component N
        port (x : in std_logic;
              y : out std_logic);
    end component;

    component NOAA
        port (x : in std_logic_vector(0 to 3);
              y : out std_logic);
    end component;                 

    signal temp_signal : std_logic;
    signal temp_vector : std_logic_vector(0 to 3);

    signal clk_signal_inv, clk_signal, d1_result, d2_result, temp_ff_signal : std_logic;

    --function rising_edge (signal s : std_logic) return boolean is
    --    begin
    --        return s = '1' and s'event;
    --end;

    begin
        temp_vector(0) <= d;
        x8: N port map(x => te, y => temp_vector(1));
        temp_vector(2) <= ti;
        temp_vector(3) <= te;

        x7: NOAA port map(x => temp_vector, y => temp_signal);
        
        clk_handling : process(clk)
            begin
                if rising_edge(clk) then
                    clk_signal_inv <= (not clk) after 2 ns;
                    clk_signal <= (not clk_signal_inv) after 2 ns;
                end if;
        end process clk_handling;

        first_d_flip_dlop : process(temp_signal, clk_signal_inv, 
                                    clk_signal, d1_result)

            variable intermediate_result : std_logic;

            begin
                intermediate_result := ((d1_result and clk_signal) nor
										(temp_signal and clk_signal_inv));
                d1_result <= (not intermediate_result) after 7 ns; -- 5 ns + 2 ns
        end process first_d_flip_dlop;
		
		second_d_flip_flop1: process(d2_result, clk_signal_inv,
									d1_result, clk_signal)				
			begin
				temp_ff_signal <= ((d2_result and clk_signal_inv) nor 
								   (d1_result and clk_signal)) after 5 ns;
		end process second_d_flip_flop1;
		
		second_d_flip_flop2: process(temp_ff_signal)
			
			variable intermediate_result : std_logic;
			
			begin
				intermediate_result := (not temp_ff_signal);
				d2_result <= intermediate_result after 2 ns;
		end process second_d_flip_flop2;
		
		out_put: process(temp_ff_signal)
		
			variable intermediate_result : std_logic;
		
			begin
				intermediate_result := (not temp_ff_signal);
				qn <= intermediate_result after 2 ns;
		end process out_put;

end schema_behaviour;
