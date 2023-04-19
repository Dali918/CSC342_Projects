library ieee;
use ieee.std_logic_1164.all;
-- user library 
library work; --work library 
use work.add_sub_package.all;

-- four bit add, sub implementation 
entity  FOURBITADDSUB_Banda is 
	port
	(
		a,b: in std_logic_vector (3 downto 0); 
		k: in std_logic;
		sum: out std_logic_vector (3 downto 0);
		cout, v: out std_logic
	);
end FOURBITADDSUB_Banda;

architecture fouraddsub_arch of FOURBITADDSUB_Banda is
	--signal declarations
	signal sum4, b_inverted: std_logic_vector(3 downto 0);
	signal c4, v4: std_logic;
	--component declarations
	component FOURBITADD_Banda
		port 
	(
	a,b: in std_logic_vector (3 downto 0); -- 4 bit input vectors 
	cin: in std_logic; 	-- carry in
	sum: out std_logic_vector (3 downto 0); -- 4 bit sum vectors
	cout,v : out std_logic -- overflow detector
	);
	end component;
	
begin
	
	-- xor b with the scalar k 
	b_inverted(0)<= k xor b(0);
	b_inverted(1)<= k xor b(1);
	b_inverted(2)<= k xor b(2);
	b_inverted(3)<= k xor b(3);
	-- implement wit port map of 4 bit adder
	FAS: FOURBITADD_Banda
		port map (a=>a, b=>b_inverted, cin=>k, sum=>sum4, cout=>c4, v=>v4);
	-- outputs
	cout<=c4;
	v<=v4;
	sum<=sum4;
end fouraddsub_arch;
	