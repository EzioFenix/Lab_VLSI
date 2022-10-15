library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --nuevos tipos de datos usigned

-----------------------------
--Muxn ==p15
entity p15 is
	generic (N : positive :=2);
	port(
		entrada : in std_logic_vector(2**N-1 downto 0); --i
		selector : in std_logic_vector(N-1 downto 0); --s
		enable : in std_logic; --e
		salida : out std_logic --y 
		);
end entity p15;
-----------------------------

architecture  behavior of  p15 is
begin
	salida <= entrada (to_integer(unsigned(selector))) and enable;

end  behavior;