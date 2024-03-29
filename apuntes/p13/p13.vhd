library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

---------
entity p13 is
	generic (N : positive :=4);
	port(
			a : in std_logic_vector(N-1 downto 0);
			b : in std_logic_vector(N-1 downto 0);
			mayor,menor,igual : out std_logic
	);

end entity p13;


architecture behavior of p13 is begin
	mayor <= '1' when signed(a) > signed(b) else '0';
	menor <='1' when signed(a) < signed(b) else '0';
	igual <='1' when signed(a) = signed(b) else '0';

end architecture behavior;