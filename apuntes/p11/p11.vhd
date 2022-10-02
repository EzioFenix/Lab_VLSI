library ieee;
use ieee.std_logic_1164.all;

entity p11 is
	port (
		selector: in std_logic_vector(3 downto 0);
		salida : out std_logic_vector( 1 downto 0);
		comprobador: out std_logic 
	);

end entity p11;


architecture behavior of p11 is begin
	
	salida <= "11" when selector(3) ='1' else
				 "10" when selector(2) ='1' else
				 "01" when selector(1) ='1' else
				 "00";
				 
	comprobador <= selector(3) or selector(2) or selector(1) or selector(0);

end architecture behavior;