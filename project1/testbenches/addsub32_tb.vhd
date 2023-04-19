LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- user library
LIBRARY work;
USE work.add_sub_package.ALL;

ENTITY addsub32_tb IS
END ENTITY addsub32_tb;

ARCHITECTURE behavior OF addsub32_tb IS

    COMPONENT NBITADDSUB_Banda IS
        GENERIC (N : NATURAL := 32);
        PORT (
            A, B : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            cin, k : IN STD_LOGIC;
            sum : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            cout, overflow, zero, negative : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a, b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL cin : STD_LOGIC;
    SIGNAL op : STD_LOGIC;
    SIGNAL sum : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL co : STD_LOGIC;
    SIGNAL ov : STD_LOGIC;
    SIGNAL zero : STD_LOGIC;
    SIGNAL neg : STD_LOGIC;

BEGIN
    UUT : NBITADDSUB_Banda PORT MAP(A => a, B => b, cin => cin, k => op, sum => sum, cout => co, overflow => ov, zero => zero, negative => neg);
    PROCESS
    BEGIN
        -- Test case for adding 1 to the most positive 32-bit integer
        a <= x"7FFFFFFF"; -- most positive 32-bit integer
        b <= x"00000001"; -- add 1
        op <= '0'; -- addition operation
        WAIT FOR 100 ns;
        ASSERT sum = x"80000000" AND co = '1' AND ov = '1'
        REPORT "Test case 1 failed" SEVERITY error;
        -- The result should be the most negative 32-bit integer with both carry-out and overflow

        -- Test case for adding 1 to the most negative 32-bit integer
        a <= x"80000000"; -- most negative 32-bit integer
        b <= x"00000001"; -- add 1
        op <= '0'; -- addition operation
        WAIT FOR 100 ns;
        ASSERT sum = x"80000001" AND co = '0' AND ov = '1'
        REPORT "Test case 2 failed" SEVERITY error;
        -- The result should be -2^31 + 1 with overflow but no carry-out

        -- Test case for subtracting 1 from the most negative 32-bit integer
        a <= x"80000000"; -- most negative 32-bit integer
        b <= x"00000001"; -- subtract 1 (2's complement)
        op <= '1'; -- subtraction operation
        WAIT FOR 100 ns;
        ASSERT sum = x"7FFFFFFF" AND co = '1' AND ov = '0'
        REPORT "Test case 3 failed" SEVERITY error;
        -- The result should be the most positive 32-bit integer with carry-out but no overflow

        -- Test case for subtracting the most positive 32-bit integer from itself
        a <= x"7FFFFFFF"; -- most positive 32-bit integer
        b <= x"7FFFFFFF"; -- 2's complement of the most positive 32-bit integer
        op <= '1'; -- subtraction operation
        WAIT FOR 100 ns;
        ASSERT sum = x"00000000" AND co = '1' AND ov = '0'
        REPORT "Test case 4 failed" SEVERITY error;
        -- The result should be 0 with carry-out but no overflow

        REPORT "All test cases passed" SEVERITY note;
        WAIT FOR 100 ns;
    END PROCESS;
END ARCHITECTURE behavior;