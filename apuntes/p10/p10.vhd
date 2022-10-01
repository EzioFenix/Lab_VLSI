library ieee;
use ieee.std_logic_1164.all;

-- 
entity p10 is 
	port(
		entrada : in std_logic_vector(3 downto 0);
		selector : in std_logic_vector (1 downto 0);
		salida: out std_logic
	);
end entity p10;

architecture behavior of p10 is begin
	
	with selector select
		salida <= entrada(0) when "00",
					entrada(1) when "01",
					entrada(2) when "10",
					entrada(3) when others;

end architecture behavior;