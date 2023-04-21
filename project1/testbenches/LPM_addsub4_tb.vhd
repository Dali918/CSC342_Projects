LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.numeric_std_unsigned.ALL;

ENTITY LPM_addsub4_tb IS
END ENTITY LPM_addsub4_tb;

ARCHITECTURE behavior OF LPM_addsub4_tb IS

    -- LPM Component
    COMPONENT LPM_addsub4 IS
        PORT (
            add_sub : IN STD_LOGIC;
            cin : IN STD_LOGIC;
            dataa : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            datab : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            cout : OUT STD_LOGIC;
            overflow : OUT STD_LOGIC;
            result : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    ----
    -- Declare the signals used in the testbench 
    SIGNAL a : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL cin, cout, ovf, zero, neg, mode : STD_LOGIC;
BEGIN

    UUT : NBITADDSUB_Banda PORT MAP(dataa => a, dataab => b, cin => cin, add_sub => mode, result => sum, cout => cout, overflow => ovf);
    PROCESS
    BEGIN
        -- test for Most Negative N bit integer + 1
        a <= "1000";
        b <= "0001";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "1001" AND cout = '0' AND ovf = '0'  REPORT "Most Negative N bit integer + 1 test failed" SEVERITY error;

        -- test for Most Positive N bit integer + 1
        a <= "0111";
        b <= "0001";
        mode <= '0';
        WAIT FOR 100 ns;
        ASSERT sum = "1000" AND cout = '1' AND ovf = '0' REPORT "Most Positive N bit integer + 1 test failed" SEVERITY error;

        -- test for Most Positive N bit integer - itself
        a <= "0111";
        b <= "0111";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "0000" AND cout = '1' AND ovf = '0'  REPORT "Most Positive N bit integer - itself test failed" SEVERITY error;

        -- test for Most Negative N bit integer - itself
        a <= "1000";
        b <= "1000";
        mode <= '1';
        WAIT FOR 100 ns;
        ASSERT sum = "0000" AND cout = '1' AND ovf = '0' REPORT "Most Negative N bit integer - itself test failed" SEVERITY error;
    END PROCESS;
END ARCHITECTURE behavior;