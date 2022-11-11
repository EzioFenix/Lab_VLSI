library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------
entity sumador is
	generic (
			N : positive:=3
		);
	port (
			a_i: in std_logic_vector (N-1 downto 0);
			b_i: in std_logic_vector (N-1 downto 0);
			c_i: in std_logic_vector (0 downto 0);
			sum_o : out std_logic_vector (N-1 downto 0);
			co_o : out std_logic
		);
end entity sumador;

------------------
architecture arq of sumador is
	signal auxSum : unsigned(N downto 0);
begin
	auxSum<= '0' & unsigned (a_i) + unsigned (b_i) + unsigned(c_i);

	sum_o <= std_logic_vector (auxSum(N-1 downto 0));
	co_o <= auxSum(N);

end architecture arq;