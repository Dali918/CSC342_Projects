library ieee;
use ieee.std_logic_1164.all;
-- user library
library work;  
use work.add_sub_package.all;

entity  FOURBITADD_Banda is 
	port 
	(
	a,b: in std_logic_vector (3 downto 0); -- 4 bit input vectors 
	cin: in std_logic; 	-- carry in
	sum: out std_logic_vector (3 downto 0); -- 4 bit sum vectors
	cout,v : out std_logic -- overflow detector
	);
end FOURBITADD_Banda;

architecture fouradd_arch of FOURBITADD_Banda is 
	signal c: std_logic_vector (4 downto 0);	-- carry vector
	-- full adder as component
	component full_adder_Banda
		port
		(
			A,B,Cin: in std_logic;
			Sum, Cout: out std_logic
		);
	end component;
begin
	-- full adders 
	FA0: full_adder_Banda
		port map (A=>a(0), B=>b(0), Cin=>cin, Sum=>sum(0), Cout=>c(1)); 
	FA1: full_adder_Banda
		port map (A=>a(1), B=>b(1), Cin=>c(1), Sum=>sum(1), Cout=>c(2));
	FA2: full_adder_Banda
		port map (A=>a(2), B=>b(2), Cin=>c(2), Sum=>sum(2), Cout=>c(3));
	FA3: full_adder_Banda
		port map (A=>a(3), B=>b(3), Cin=>c(3), Sum=>sum(3), Cout=>c(4));
		
	cout<= c(4);		-- carry out 
	v<= c(4) xor c(3); -- overflow detector 

end fouradd_arch;