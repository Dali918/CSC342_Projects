LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.numeric_std_unsigned.ALL;

ENTITY addsub4_tb IS
END ENTITY addsub4_tb;

ARCHITECTURE behavior OF addsub4_tb IS
    -- Import the design unit being tested

    COMPONENT NBITADDSUB_Banda IS
        GENERIC (N : NATURAL := 4);
        PORT (
            A, B : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            cin, k : IN STD_LOGIC;
            sum : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            cout, overflow, zero, negative : OUT STD_LOGIC
        );
    END COMPONENT;
    -- Declare the signals used in the testbench 
    SIGNAL a : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL cin, cout, ovf, zero, neg, mode : STD_LOGIC;
BEGIN

    UUT : NBITADDSUB_Banda PORT MAP(A => a, B => b, cin => cin, k => mode, sum => sum, cout => cout, overflow => ovf, zero => zero, negative => neg);
    PROCESS
    BEGIN
        -- test for Most Negative N bit integer + 1
        a <= "1000";
        b <= "0001";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "1001" AND cout = '0' AND ovf = '0' AND zero = '0' AND neg = '1' REPORT "Most Negative N bit integer + 1 test failed" SEVERITY error;

        -- test for Most Positive N bit integer + 1
        a <= "0111";
        b <= "0001";
        mode <= '0';
        WAIT FOR 100 ns;
        ASSERT sum = "1000" AND cout = '1' AND ovf = '0' AND zero = '0' AND neg = '0' REPORT "Most Positive N bit integer + 1 test failed" SEVERITY error;

        -- test for Most Positive N bit integer - itself
        a <= "0111";
        b <= "0111";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "0000" AND cout = '1' AND ovf = '0' AND zero = '1' AND neg = '0' REPORT "Most Positive N bit integer - itself test failed" SEVERITY error;

        -- test for Most Negative N bit integer - itself
        a <= "1000";
        b <= "1000";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "0000" AND cout = '1' AND ovf = '0' AND zero = '1' AND neg = '0' REPORT "Most Negative N bit integer - itself test failed" SEVERITY error;
    END PROCESS;
END ARCHITECTURE behavior;