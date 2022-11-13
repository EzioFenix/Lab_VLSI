LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY corri IS
	PORT (
		reloj : IN std_logic;
		display1, display2, display3, display4, display5, display6, display7, display8 : BUFFER std_logic_vector (6 DOWNTO 0)
	);
END corri;

ARCHITECTURE Behavioral OF corri IS SIGNAL segundo : std_logic;
	SIGNAL Q : std_logic_vector (3 DOWNTO 0) := "0000";

BEGIN
	divisor : PROCESS (reloj)
		VARIABLE cuenta : std_logic_vector(27 DOWNTO 0) := X"0000000";
	BEGIN
		IF rising_edge(reloj) THEN
			IF cuenta = X"48009E0" THEN
				cuenta := X"0000000";
			ELSE
				cuenta := cuenta + 1;
			END IF;
		END IF;
		segundo <= cuenta(22);
	END PROCESS;

	contador : PROCESS (segundo)
	BEGIN
		IF rising_edge(segundo) THEN
			Q <= Q + 1;
		END IF;
	END PROCESS;

	WITH Q SELECT
	display1 <= "0000110" WHEN "0000", -- E
	            "0101011" WHEN "0001", -- n
	            "1111111" WHEN "0010", -- espacio
	            "1000111" WHEN "0011", -- L
	            "0001000" WHEN "0100", -- A
	            "1111111" WHEN "0101", -- espacio
	            "1000000" WHEN "0110", -- O
	            "0000111" WHEN "0111", -- L
	            "0001000" WHEN "1000", -- A
	            "1111111" WHEN  others;-- espacio

	            FF1 : PROCESS (segundo)
	            BEGIN
		            IF rising_edge(segundo) THEN
			            display2 <= display1;
		END IF;
	END PROCESS;

	FF2 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display3 <= display2;
		END IF;
	END PROCESS;

	FF3 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display4 <= display3;
		END IF;
	END PROCESS;

	FF4 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display5 <= display4;
		END IF;
	END PROCESS;

	FF5 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display6 <= display5;
		END IF;
	END PROCESS;

	FF6 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display7 <= display6;
		END IF;
	END PROCESS;

	FF7 : PROCESS (segundo)
	BEGIN
		IF rising_edge (segundo) THEN
			display8 <= display7;
		END IF;
END PROCESS;
end architecture;