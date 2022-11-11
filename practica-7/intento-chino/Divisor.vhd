Library IEEE;
Use IEEE.Std_logic_1164.ALL;
Use IEEE.Std_logic_arith.ALL;
Use IEEE.Std_logic_unsigned.ALL;

Entity Divisor is
Port( CLK: in std_logic;
		clkl : out std_logic);
End Divisor;

architecture Behavioral of Divisor is
Begin
	process (CLK)
		Constant N : integer := 17;
		variable cuenta : std_logic_vector (27 downto 0) := X"0000000";		
			Begin
				if rising_edge(CLK) then
						cuenta := cuenta + 1;
				End if;
				clkl <= cuenta(N);
			
	End process;
End Behavioral;