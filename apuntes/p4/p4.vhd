library ieee;
use ieee.std_logic_1164.all;

entity p4 is
	port (
	a : in std_logic;
	b : in std_logic;
	y : out std_logic
	);
end entity p4;

architecture  behavior of p4 is
	signal entradas: std_logic_vector (1 downto 0);
begin
	entradas <= a & b;
	
	with entradas select
		y<='1' when "11",
			'0' when "01" |"10"|"00",
			'0' when others;
			
end architecture behavior;