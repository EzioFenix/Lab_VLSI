-- practica 8
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_std.STD.ALL;

ENTITY TX IS
	PORT (
		reloj : IN STD_LOGIC;
		sw : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		led : OUT STD_LOGIC;
		tx_wire : OUT STD_LOGIC
	);
END ENTITY;

---------
ARCHITECTURE behaivoral OF TX IS
	SIGNAL conta : INTEGER := 0;
	SIGNAL valor : INTEGER := 70000;
	SIGNAL inicio : STD_LOGIC;
	SIGNAL dato : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL pre : INTEGER RANGE 0 TO 5208 := 0;
	SIGNAL indice : INTEGER RANGE 0 TO 9 := 0;
	SIGNAL buff : STD_LOGIC_VECTOR (9 DOWNTO 0);
	SIGNAL flag : STD_LOGIC := '0';
	SIGNAL pre_val : INTEGER RANGE 0 TO 41600;
	SIGNAL baud : STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL i : INTEGER RANGE 0 TO 4;
	SIGNAL pulso : STD_LOGIC := '0';
	SIGNAL contador : INTEGER RANGE 0 TO 49999999 := 0;
	SIGNAL dato_bin : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL hex_val : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');

---------
BEGIN
	TX_divisor : PROCESS (reloj)
	BEGIN
		IF rising_edge(reloj) THEN
			contador <= contador + 1;
			IF (contador < 140000) THEN
				pulso <= '1';
			ELSE
				pulso <= '0';
			END IF;
		END IF;
	END PROCESS TX_divisor;

---------
	TX_prepara : PROCESS (reloj, pulso)
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
	END PROCESS TX_prepara;

---------
	TX_envia : PROCESS (reloj, inicio, dato)
	BEGIN
		IF (reloj'EVENT AND reloj = '1') THEN
			IF (flag = '0' AND inicio = '1') THEN
				flag <= '1';
				buff(0) <= '0';
				buff(9) <= '1';
				buff(8 DOWNTO 1) <= dato;
			END IF;
			IF (flag = '1') THEN
				IF (pre < pre_val) THEN
					pre <= pre + 1;
				ELSE
					pre <= 0;
				END IF;
				IF (pre = pre_val/2) THEN
					tx_wire <= buff(indice);
					IF (indice < 9) THEN
						indice <= indice + 1;
					ELSE
						flag <= '0';
						indice <= 0;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS TX_envia;
	
---------
	led <= pulso;
	dato_bin <= sw;
	baud <= "011";

	WITH(dato_bin) SELECT
	hex_val <= X"30" WHEN "0000",
		X"31" WHEN "0001",
		X"32" WHEN "0010",
		X"33" WHEN "0011",
		X"34" WHEN "0100",
		X"35" WHEN "0101",
		X"36" WHEN "0110",
		X"37" WHEN "0111",
		X"38" WHEN "1000",
		X"39" WHEN "1001",
		X"41" WHEN "1010",
		X"42" WHEN "1011",
		X"43" WHEN "1100",
		X"44" WHEN "1101",
		X"45" WHEN "1110",
		X"46" WHEN "1111",
		X"23" WHEN OTHERS;

	WITH (baud) SELECT
	pre_val <= 41600 WHEN "000", -- 1200 bauds
		20800 WHEN "001", -- 2400 bauds
		10400 WHEN "010", -- 9600 bauds
		5200 WHEN "011", -- 19200 bauds
		2600 WHEN "100", -- 38400 bauds
		1300 WHEN "101", -- 38400 bauds
		866 WHEN "110", -- 57600 bauds
		432 WHEN OTHERS; --115200 bauds
END ARCHITECTURE behaivoral;