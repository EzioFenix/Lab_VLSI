--Declararion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --nuevos tipos de datos usigned


----
entity p12 is
	port(
		n_i : in std_logic_vector(3 downto 0);
		a_o : out std_logic_vector(3 downto 0);
		error : out std_logic
		);
end entity p12;

-------
architecture behavior of p12 is begin

	a_o <= n_i when unsigned(n_i) < 5  else
		"0000"  when  9 <  unsigned(n_i) 
		else std_logic_vector(unsigned(n_i) + 6);
		
	-- saber error
	error <= "1  when  9 <  unsigned(n_i)
			else '0';
		
	
	
	end architecture behavior;
	
	