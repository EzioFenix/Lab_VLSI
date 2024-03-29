library ieee;
use ieee.std_logic_1164.all;

entity p14 is
	generic (N : integer:= 4);
	port(
		entrada: in std_logic_vector(N-1 downto 0);
		salida: out std_logic_vector(N-1 downto 0)
	);
end entity p14;


architecture behavior of p14 is
	signal baux : std_logic_vector(N-1 downto 0);
begin
	baux(N-1) <= entrada (N-1);
	baux(N-2 downto 0) <= baux(N-1 downto 1) xor entrada(N-2 downto 0);
	
	salida<= baux;
end architecture behavior;