LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE IEEE.Std_logic_arith.ALL;
USE IEEE.Std_logic_unsigned.ALL;
ENTITY practica9 IS
	PORT (
		reloj : IN STD_LOGIC;
		SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		LED : OUT STD_LOGIC;
		TX_WIRE : OUT STD_LOGIC
	);
END ENTITY;
ARCHITECTURE behavioral OF practica9 IS
	SIGNAL conta : INTEGER := 0;
	SIGNAL valor : INTEGER := 70000;
	SIGNAL INICIO : STD_LOGIC;
	SIGNAL dato : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Flag : STD_LOGIC := '0';
	SIGNAL PRE : INTEGER RANGE 0 TO 5208 := 0;
	SIGNAL INDICE : INTEGER RANGE 0 TO 9 := 0;
	SIGNAL PRE_val : INTEGER RANGE 0 TO 41600;
	SIGNAL baud : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL i : INTEGER := 0;
	SIGNAL pulso : STD_LOGIC := '0';
	SIGNAL conta2 : INTEGER RANGE 0 TO 49999999 := 0; -- Para el divisor
	SIGNAL dato_bin : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL hex_val : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	signal BUFF :STD_LOGIC_VECTOR (9 DOWNTO 0);
BEGIN

	TX_divisor : PROCESS (reloj)
	BEGIN
	if rising_edge(reloj) then
		conta2 <=conta2 +1;
		if (conta2 < 140000) then
			pulso <= '1';
		else
			pulso <= '0';
		end if;
	end if;
	END PROCESS;

	
	
	Prepara_dato : PROCESS (reloj, pulso)
		TYPE arreglo IS ARRAY (0 TO 1) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
		VARIABLE asc_dato : arreglo := (X"30", X"0A");
	BEGIN
		asc_dato(0) := hex_val;
		IF (pulso = '1') THEN
			IF rising_edge(reloj) THEN
				IF (conta = valor) THEN
					conta <= 0;
					INICIO <= '1';
					dato <= asc_dato(i);
					IF (i = 1) THEN
						i <= 0;
					ELSE
						i <= i + 1;
					END IF;
				ELSE
					conta <= conta + 1;
					inicio <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS ;
	
	TX_envia : PROCESS (reloj, inicio, dato)
	BEGIN
		IF (reloj'EVENT AND reloj = '1') THEN
			IF (FLAG = '0' AND INICIO = '1') THEN
				FLAG <= '1';
				BUFF(0) <= '0';
				BUFF(9) <= '1';
				BUFF (8 DOWNTO 1) <= dato;
			END IF;
			IF (FLAG = '1') THEN
				IF (PRE < PRE_val) THEN
					PRE <= PRE + 1;
				ELSE
					PRE <= 0;
				END IF;
				IF (PRE = PRE_val/2) THEN
					TX_WIRE <= BUFF(INDICE);
					IF (INDICE < 9) THEN
						INDICE <= INDICE + 1;
					ELSE
						FLAG <= '0';
						INDICE <= 0;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS TX_envia;
	
	baud <= "011";
	WITH (baud) SELECT
	PRE_val <= 41600 WHEN "000", --1200 bauds
		20800 WHEN "001", --2400 bauds
		10400 WHEN "010", --4800 bauds
		5200 WHEN "011", --9600 bauds
		2600 WHEN "100", --19200 bauds
		1300 WHEN "101", --38400 bauds
		866 WHEN "110", --57600 bauds
		432 WHEN OTHERS; --115200 bauds
END ARCHITECTURE behavioral;