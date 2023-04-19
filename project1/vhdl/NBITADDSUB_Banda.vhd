LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
-- user library
LIBRARY work;
USE work.add_sub_package.ALL;

ENTITY NBITADDSUB_Banda IS
	GENERIC (N : NATURAL := 32);
	PORT (
		A, B : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
		cin, k : IN STD_LOGIC;
		sum : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
		cout, overflow, zero, negative : OUT STD_LOGIC
	);
END NBITADDSUB_Banda;

ARCHITECTURE nbit_behavioral_dataflow OF NBITADDSUB_Banda IS
	SIGNAL s, carry_vector, complement : STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
BEGIN
	complement <= B WHEN k = '0' ELSE (NOT(B) + 1);
	initial : full_adder_Banda PORT MAP(A(0), complement(0), k, s(0), carry_vector(0)); -- compute initial bit sum and generate carry 

	nbit_loop : FOR i IN 1 TO N - 1 GENERATE
		FA_N : full_adder_Banda PORT MAP(A(i), complement(i), carry_vector(i - 1), s(i), carry_vector(i)); -- compute remaining bit sum and carries
	END GENERATE nbit_loop;
	sum <= s;

	-- flags
	
	cout <= carry_vector(N - 1);
	overflow <= carry_vector(N - 1) XOR carry_vector(N - 2);
	zero <= '1' WHEN (s = (s' RANGE => '0')) ELSE '0';
	negative <= s(n - 1);

END nbit_behavioral_dataflow;