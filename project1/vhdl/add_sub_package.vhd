library ieee;  -- library declaration
use ieee.std_logic_1164.all; --use the library declaration 

package add_sub_package is 
-- half adder component
component half_adder_Banda is	 
	port(a,b: in std_logic; sum,carry: out std_logic);
end component;


-- full adder component
component full_adder_Banda is 
	port
	(
	A, B, Cin: in std_logic;  -- full adder input and carry in 
	Sum, Cout: out std_logic -- full adder sum and carry 
	);
end component;

-- four bit adder component
component FOURBITADD_Banda is 
	port 
	(
	a,b: in std_logic_vector (3 downto 0); -- 4 bit input vectors 
	cin: in std_logic; 	-- carry in
	sum: out std_logic_vector (3 downto 0); -- 4 bit sum vectors
	cout,v : out std_logic -- overflow detector
	);
end component;

-- four bit adder subtractor component
component  FOURBITADDSUB_Banda is 
	port
	(
		a,b: in std_logic_vector (3 downto 0); 
		cin: in std_logic;
		sum: out std_logic_vector (3 downto 0);
		cout, v: out std_logic
	);
end component;
-- n bit adder subtractor component
component NBITADDSUB_Banda is
	generic (N: natural := 2);
	port
	(
		A,B: in std_logic_vector (N-1 downto 0); 
		cin, k : IN STD_LOGIC;
		sum: out std_logic_vector (N-1 downto 0);
		cout, overflow, zero, negative: out std_logic
	);
end component;

end package add_sub_package;
