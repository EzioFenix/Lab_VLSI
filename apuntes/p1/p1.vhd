library ieee;
use ieee.std_logic_1164.all;


------------------------------------------------
--and1_when_else
entity p1 is
	port (
		a : in std_logic;
		b : in std_logic;
		y_o : out std_logic
		);
end p1;

---------------------------

architecture flujo of p1 is begin
	y_o<= a when b='1' else '0';

end architecture flujo;