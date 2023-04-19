
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;



entity encoder_4to2_tb is
end entity encoder_4to2_tb;

architecture behavior of encoder_4to2_tb is
    -- Import the design unit being tested
    component encoder4to2 is
        port (
            in_3 : in std_logic;
            in_2 : in std_logic;
            in_1 : in std_logic;
            in_0 : in std_logic;
            out_0 : out std_logic;
            out_1 : out std_logic
        );
    end component;

    -- Declare the signals used in the testbench
    signal in_0_sig : std_logic;
    signal in_1_sig : std_logic;
    signal in_2_sig : std_logic;
    signal in_3_sig : std_logic;
    signal out_0_sig : std_logic;
    signal out_1_sig : std_logic;

begin
    -- Instantiate the design unit being tested
    UUT : encoder4to2
    port map (
        in_0 => in_0_sig,
        in_1 => in_1_sig,
        in_2 => in_2_sig,
        in_3 => in_3_sig,
        out_0 => out_0_sig,
        out_1 => out_1_sig
    );

    -- Generate all possible input combinations using a for loop
    process
    begin
        for i in 0 to 15 loop
            in_0_sig <= std_logic(to_unsigned((i mod 2), 1)(0));
            in_1_sig <= std_logic(to_unsigned((i/2 mod 2), 1)(0));
            in_2_sig <= std_logic(to_unsigned((i/4 mod 2), 1)(0));
            in_3_sig <= std_logic(to_unsigned((i/8 mod 2), 1)(0));
            
            
            wait for 10 ns;
            
            -- Check that the output matches the expected result
            case i is
                when 0 =>
                    assert (out_0_sig = '0' and out_1_sig = '0')
                        report "Error: i=0, out_0_sig=" & std_logic'image(out_0_sig) & ", out_1_sig=" & std_logic'image(out_1_sig);
                when 2 =>
                    assert (out_0_sig = '1' and out_1_sig = '0')
                        report "Error: i=1, out_0_sig=" & std_logic'image(out_0_sig) & ", out_1_sig=" & std_logic'image(out_1_sig);
                when 4 =>
                    assert (out_0_sig = '0' and out_1_sig = '1')
                        report "Error: i=2, out_0_sig=" & std_logic'image(out_0_sig) & ", out_1_sig=" & std_logic'image(out_1_sig);
                when 8 =>
                    assert (out_0_sig = '1' and out_1_sig = '1')
                        report "Error: i=3, out_0_sig=" & std_logic'image(out_0_sig) & ", out_1_sig=" & std_logic'image(out_1_sig);
                when others => 
                    assert false
                        report "Error: i=" & integer'image(i);
            end case;
        end loop;
        wait;
    end process;
end behavior;
