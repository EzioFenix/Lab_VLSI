LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE IEEE.Std_logic_unsigned.ALL;
ENTITY Practica4 IS
	GENERIC (FREQ_CLK : INTEGER := 50_000_00);
	PORT (
		CLK : IN STD_LOGIC;
		COLUMNAS : IN std_logic_vector(3 DOWNTO 0);
		FILAS : OUT std_logic_vector(3 DOWNTO 0);
		BOTON_PRES : inout std_logic_vector (3 DOWNTO 0);
		IND : OUT std_logic;
		LED_out : OUT std_logic_vector(6 downto 0)
	);
END Practica4;
ARCHITECTURE behavioral OF Practica4 IS
	CONSTANT DELAY_1MS : INTEGER := (FREQ_CLK/1000) - 1;
	CONSTANT DELAY_10MS : INTEGER := (FREQ_CLK/100) - 1;
	SIGNAL CONTA_1MS : INTEGER RANGE 0 TO DELAY_1MS := 0;
	SIGNAL BANDERA : STD_LOGIC := '0';
	SIGNAL CONTA_10MS : INTEGER RANGE 0 TO DELAY_10MS := 0;
	SIGNAL BANDERA2 : STD_LOGIC := '0';
	SIGNAL BOT_1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_2 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_3 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_4 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_5 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_6 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_7 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_8 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_9 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_A : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_B : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_C : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_D : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_AS : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL BOT_GA : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL FILA_REG_S : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL FILA : INTEGER RANGE 0 TO 3 := 0;
	SIGNAL IND_S : STD_LOGIC := '0';
	SIGNAL EDO : INTEGER RANGE 0 TO 1 := 0;
	--SIGNAL FILA_REG_S : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS=>'0');
	--SIGNAL FILA : INTEGER RANGE 0 TO 3 := 0;
	--SIGNAL IND_S : STD_LOGIC := '0';
	--SIGNAL EDO : INTEGER RANGE 0 TO 1 := 0;
	--agregado-_-------
BEGIN
	FILAS <= FILA_REG_S;
	--RETARDO 1 MS--
	PROCESS (CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			CONTA_1MS <= CONTA_1MS + 1;
			BANDERA <= '0';
			IF CONTA_1MS = DELAY_1MS THEN
				CONTA_1MS <= 0;
				BANDERA <= '1';
			END IF;
		END IF;
	END PROCESS;
	----------------
	--RETARDO 10 MS--
	PROCESS (CLK)
		BEGIN
			IF RISING_EDGE(CLK) THEN
				CONTA_10MS <= CONTA_10MS + 1;
				BANDERA2 <= '0';
				IF CONTA_10MS = DELAY_10MS THEN
					CONTA_10MS <= 0;
					BANDERA2 <= '1';
				END IF;
			END IF;
		END PROCESS;
		----------------
		--PROCESO EN LAS FILAS ----
		PROCESS (CLK, BANDERA2)
			BEGIN
				IF RISING_EDGE(CLK) AND BANDERA2 = '1' THEN
					FILA <= FILA + 1;
					IF FILA = 3 THEN
						FILA <= 0;
					END IF;
				END IF;
			END PROCESS;
			WITH FILA SELECT
			FILA_REG_S <= "1000" WHEN 0, --r3 r2 r1 r2, r3 va tener 5 volts
			              "0100" WHEN 1, 
			              "0010" WHEN 2, 
			              "0001" WHEN OTHERS;
			-------------------------------
			----------PROCESO EN EL TECLADO AL SELECCIONAR UN VALOR------------
			PROCESS (CLK, BANDERA)
				BEGIN
					IF RISING_EDGE(CLK) AND BANDERA = '1' THEN
						IF FILA_REG_S = "1000" THEN
							--modificacion de los registros
							BOT_1 <= BOT_1(6 DOWNTO 0) & COLUMNAS(3); --7 bits + columna 3 = manda un 1
							BOT_2 <= BOT_2(6 DOWNTO 0) & COLUMNAS(2);
							BOT_3 <= BOT_3(6 DOWNTO 0) & COLUMNAS(1);
							BOT_A <= BOT_A(6 DOWNTO 0) & COLUMNAS(0);
						ELSIF FILA_REG_S = "0100" THEN
							BOT_4 <= BOT_4(6 DOWNTO 0) & COLUMNAS(3);
							BOT_5 <= BOT_5(6 DOWNTO 0) & COLUMNAS(2);
							BOT_6 <= BOT_6(6 DOWNTO 0) & COLUMNAS(1);
							BOT_B <= BOT_B(6 DOWNTO 0) & COLUMNAS(0);
						ELSIF FILA_REG_S = "0010" THEN
							BOT_7 <= BOT_7(6 DOWNTO 0) & COLUMNAS(3);
							BOT_8 <= BOT_8(6 DOWNTO 0) & COLUMNAS(2);
							BOT_9 <= BOT_9(6 DOWNTO 0) & COLUMNAS(1);
							BOT_C <= BOT_C(6 DOWNTO 0) & COLUMNAS(0);
						ELSIF FILA_REG_S = "0001" THEN
							BOT_AS <= BOT_AS(6 DOWNTO 0) & COLUMNAS(3);
							BOT_0 <= BOT_0(6 DOWNTO 0) & COLUMNAS(2);
							BOT_GA <= BOT_GA(6 DOWNTO 0) & COLUMNAS(1);
							BOT_D <= BOT_D(6 DOWNTO 0) & COLUMNAS(0);
						END IF;
					END IF;
				END PROCESS;
				----------------------------------------------------------------------------
				--SALIDA--
				PROCESS (CLK)
					BEGIN
						IF RISING_EDGE(CLK) THEN
							IF BOT_0 = "11111111" THEN
								BOTON_PRES <= X"0";
								IND_S <= '1';
							ELSIF BOT_1 = "11111111" THEN
								BOTON_PRES <= X"1";
								IND_S <= '1';
							ELSIF BOT_2 = "11111111" THEN
								BOTON_PRES <= X"2";
								IND_S <= '1';
							ELSIF BOT_3 = "11111111" THEN
								BOTON_PRES <= X"3";
								IND_S <= '1';
							ELSIF BOT_4 = "11111111" THEN
								BOTON_PRES <= X"4";
								IND_S <= '1';
							ELSIF BOT_5 = "11111111" THEN
								BOTON_PRES <= X"5";
								IND_S <= '1';
							ELSIF BOT_6 = "11111111" THEN
								BOTON_PRES <= X"6";
								IND_S <= '1';
							ELSIF BOT_7 = "11111111" THEN
								BOTON_PRES <= X"7";
								IND_S <= '1';
							ELSIF BOT_8 = "11111111" THEN
								BOTON_PRES <= X"8";
								IND_S <= '1';
							ELSIF BOT_9 = "11111111" THEN
								BOTON_PRES <= X"9";
								IND_S <= '1';
							ELSIF BOT_A = "11111111" THEN
								BOTON_PRES <= X"A";
								IND_S <= '1';
							ELSIF BOT_B = "11111111" THEN
								BOTON_PRES <= X"B";
								IND_S <= '1';
							ELSIF BOT_C = "11111111" THEN
								BOTON_PRES <= X"C";
								IND_S <= '1';
							ELSIF BOT_D = "11111111" THEN
								BOTON_PRES <= X"D";
								IND_S <= '1';
							ELSIF BOT_AS = "11111111" THEN
								BOTON_PRES <= X"E";
								IND_S <= '1';
							ELSIF BOT_GA = "11111111" THEN
								BOTON_PRES <= X"F";
								IND_S <= '1';
							ELSE
								IND_S <= '0';
							END IF;
						END IF;
						
					case  BOTON_PRES is
					 when "0000" => LED_out <= "0000001"; -- "0"     
					 when "0001" => LED_out <= "1001111"; -- "1" 
					 when "0010" => LED_out <= "0010010"; -- "2" 
					 when "0011" => LED_out <= "0000110"; -- "3" 
					 when "0100" => LED_out <= "1001100"; -- "4" 
					 when "0101" => LED_out <= "0100100"; -- "5" 
					 when "0110" => LED_out <= "0100000"; -- "6" 
					 when "0111" => LED_out <= "0001111"; -- "7" 
					 when "1000" => LED_out <= "0000000"; -- "8"     
					 when "1001" => LED_out <= "0000100"; -- "9" 
					 when "1010" => LED_out <= "0000010"; -- a
					 when "1011" => LED_out <= "1100000"; -- b
					 when "1100" => LED_out <= "0110001"; -- C
					 when "1101" => LED_out <= "1000010"; -- d
					 when "1110" => LED_out <= "0110000"; -- E
					 when "1111" => LED_out <= "0111000"; -- F
					 end case;
					
					END PROCESS;
					-----------------------------
					--ACTIVACIÓN PARA LA BANDERA UN CICLO DE RELOJ--
					PROCESS (CLK)
						BEGIN
							IF RISING_EDGE(CLK) THEN
								IF EDO = 0 THEN
									IF IND_S = '1' THEN
										IND <= '1';
										EDO <= 1;
									ELSE
										EDO <= 0;
										IND <= '0';
									END IF;
								ELSE
									IF IND_S = '1' THEN
										EDO <= 1;
										IND <= '0';
									ELSE
										EDO <= 0;
									END IF;
								END IF;
							END IF;
						END PROCESS;
						--------------------------------------
						
						
END behavioral;