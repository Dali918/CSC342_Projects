LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- user library
LIBRARY work;
USE work.add_sub_package.ALL;

ENTITY full_adder_Banda_tb IS
END full_adder_Banda_tb;

ARCHITECTURE sim OF full_adder_Banda_tb IS

    -- Component Declaration
    COMPONENT full_adder_Banda
        PORT (
            A, B, Cin : IN STD_LOGIC;
            Sum, Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signal Declarations
    SIGNAL A_sig, B_sig, Cin_sig, Sum_sig, Cout_sig : STD_LOGIC;

BEGIN

    -- Instantiation of the Unit Under Test (UUT)
    UUT : full_adder_Banda PORT MAP(A => A_sig, B => B_sig, Cin => Cin_sig, Sum => Sum_sig, Cout => Cout_sig);

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Test Case 1
        A_sig <= '0';
        B_sig <= '0';
        Cin_sig <= '0';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '0' AND Cout_sig = '0') REPORT "Test Case 1 failed" SEVERITY error;

        -- Test Case 2
        A_sig <= '1';
        B_sig <= '0';
        Cin_sig <= '0';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '1' AND Cout_sig = '0') REPORT "Test Case 2 failed" SEVERITY error;

        -- Test Case 3
        A_sig <= '0';
        B_sig <= '1';
        Cin_sig <= '0';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '1' AND Cout_sig = '0') REPORT "Test Case 3 failed" SEVERITY error;

        -- Test Case 4
        A_sig <= '1';
        B_sig <= '1';
        Cin_sig <= '0';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '0' AND Cout_sig = '1') REPORT "Test Case 4 failed" SEVERITY error;

        -- Test Case 5
        A_sig <= '0';
        B_sig <= '0';
        Cin_sig <= '1';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '1' AND Cout_sig = '0') REPORT "Test Case 5 failed" SEVERITY error;

        -- Test Case 6
        A_sig <= '1';
        B_sig <= '0';
        Cin_sig <= '1';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '0' AND Cout_sig = '1') REPORT "Test Case 6 failed" SEVERITY error;

        -- Test Case 7
        A_sig <= '0';
        B_sig <= '1';
        Cin_sig <= '1';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '0' AND Cout_sig = '1') REPORT "Test Case 7 failed" SEVERITY error;

        -- Test Case 8
        A_sig <= '1';
        B_sig <= '1';
        Cin_sig <= '1';
        WAIT FOR 100 ns;
        ASSERT (Sum_sig = '1' AND Cout_sig = '1') REPORT "Test Case 8 failed" SEVERITY error;

        WAIT;
    END PROCESS;

END sim;