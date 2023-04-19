library ieee;  -- library declaration
use ieee.std_logic_1164.all; --use the library declaration 

entity half_adder_Banda is	--half adder entity declaration 
	port(a,b: in std_logic; sum,carry: out std_logic);
end half_adder_Banda;

architecture half_adder_architecture of half_adder_Banda is
	signal s,c: std_logic; -- internal signal declaration
begin 
	--process to describe sum using truth table values for behavioral modelling 
	process(a,b)
	begin 
		if a='0' and b ='0' then 
			s<='0';
		elsif a='0' and b ='1' then
			s<='1';
		elsif a='1' and b='0' then 
			s<='1';
		elsif a='1' and b='1' then
			s<='0';
		end if;
	end process;
	--process to describe the carry using truth table values for behavioral modelling
	process(a,b)
	begin 
		if a='1' and b='1' then 
			c<='1';
		else
			c<='0';
		end if;
	end process;
	
	sum<=s;
	carry <=c;
	
end half_adder_architecture;
	
	

