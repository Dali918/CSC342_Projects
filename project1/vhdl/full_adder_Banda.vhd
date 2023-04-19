library ieee;  -- IEEE library 
use ieee.std_logic_1164.all;  

library work; --work library 
use work.add_sub_package.all;

entity full_adder_Banda is 
	port
	(
	A, B, Cin: in std_logic;  -- full adder input and carry in 
	Sum, Cout: out std_logic -- full adder sum and carry 
	);
end full_adder_Banda;

architecture fulladder_behav of full_adder_Banda is 
	-- half adder componnent 
--	component half_adder_Banda
--		port(a,b: in std_logic; sum,carry: out std_logic);
--	end component;
	-- internal signals
	signal s1, c1, s2, c2: std_logic;
begin 
	
	-- first half adder
	ha1: half_adder_Banda port map (a=>A, b=>B, sum=> s1, carry=> c1);
	-- second half adder
	ha2: half_adder_Banda port map(a=>s1, b=>Cin, sum=> s2, carry=> c2);
	-- sum 
	Sum<=s2;
	-- carry out
	Cout <= c2 or c1;
end fulladder_behav;