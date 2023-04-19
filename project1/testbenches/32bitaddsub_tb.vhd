library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;



entity 32bitaddsub_tb is
end entity 32bitaddsub_tb;

architecture behavior of 32bitaddsub_tb is
    -- Import the design unit being tested

    component NBITADDSUB_Banda is
        generic (N: natural := 32);
        port
        (
            A,B: in std_logic_vector (N-1 downto 0); 
            k: in std_logic;
            sum: out std_logic_vector (N-1 downto 0);
            cout, overflow, zero, negative: out std_logic
        );
    end component;


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
    signal A_sig: std_logic_vector (32 downto 0);
    signal B_sig: std_logic_vector (32 downto 0);
    signal sum_sig: std_logic_vector (32 downto 0);
    signal overflow_sig, cout_sig, zero_sig, negative_sig: std_logic;
    
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

    32T: NBITADDSUB_Banda
    port map(

    );
