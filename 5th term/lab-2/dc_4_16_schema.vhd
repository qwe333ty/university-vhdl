library ieee;
use ieee.std_logic_1164.all;


entity decoder_schema is
    port(C : in bit_vector(0 to 1);
         D : in bit_vector(3 downto 0);
         Y : out bit_vector(0 to 15));
end decoder_schema;

architecture decoder_behaviour of decoder_schema is
    component N
    port(x : in bit;
         y : out bit);
    end component;

    component IIA2
    port(a, b : in bit;
         y : out bit);
     end component;

    component NA5
    port(a, b, c, d, control : in bit;
         y : out bit);
    end component;

    signal control_result : bit;
    signal inv_D : bit_vector(0 to 3);

    begin
          -- calculate result of strobing inputs
          iia2_res: IIA2 port map(a => C(0), b => C(1), y => control_result);
          
          inv_D_0: N port map(x => D(0), y => inv_D(0));         
          inv_D_1: N port map(x => D(1), y => inv_D(1));         
          inv_D_2: N port map(x => D(2), y => inv_D(2));
          inv_D_3: N port map(x => D(3), y => inv_D(3));

          out_0: NA5 port map(a => inv_D(0), b => inv_D(1), c => inv_D(2), d => inv_D(3), 
                              control => control_result, y => Y(0));
          out_1: NA5 port map(a => D(0), b => inv_D(1), c => inv_D(2), d => inv_D(3), 
                              control => control_result, y => Y(1));
          out_2: NA5 port map(a => inv_D(0), b => D(1), c => inv_D(2), d => inv_D(3), 
                              control => control_result, y => Y(2));
          out_3: NA5 port map(a => D(0), b => D(1), c => inv_D(2), d => inv_D(3), 
                              control => control_result, y => Y(3));
          out_4: NA5 port map(a => inv_D(0), b => inv_D(1), c => D(2), d => inv_D(3), 
                              control => control_result, y => Y(4));
          out_5: NA5 port map(a => D(0), b => inv_D(1), c => D(2), d => inv_D(3), 
                              control => control_result, y => Y(5));
          out_6: NA5 port map(a => inv_D(0), b => D(1), c => D(2), d => inv_D(3), 
                              control => control_result, y => Y(6));
          out_7: NA5 port map(a => D(0), b => D(1), c => D(2), d => inv_D(3), 
                              control => control_result, y => Y(7));
          out_8: NA5 port map(a => inv_D(0), b => inv_D(1), c => inv_D(2), d => D(3), 
                              control => control_result, y => Y(8));
          out_9: NA5 port map(a => D(0), b => inv_D(1), c => inv_D(2), d => D(3), 
                              control => control_result, y => Y(9));
          out_10: NA5 port map(a => inv_D(0), b => D(1), c => inv_D(2), d => D(3), 
                               control => control_result, y => Y(10));
          out_11: NA5 port map(a => D(0), b => D(1), c => inv_D(2), d => D(3), 
                               control => control_result, y => Y(11));
          out_12: NA5 port map(a => inv_D(0), b => inv_D(1), c => D(2), d => D(3), 
                               control => control_result, y => Y(12));
          out_13: NA5 port map(a => D(0), b => inv_D(1), c => D(2), d => D(3), 
                               control => control_result, y => Y(13));
          out_14: NA5 port map(a => inv_D(0), b => D(1), c => D(2), d => D(3), 
                               control => control_result, y => Y(14));
          out_15: NA5 port map(a => D(0), b => D(1), c => D(2), d => D(3), 
                               control => control_result, y => Y(15));

end decoder_behaviour;