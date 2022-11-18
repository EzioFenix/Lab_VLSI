--Entregable
LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE IEEE.Std_logic_arith.ALL;
USE IEEE.Std_logic_unsigned.ALL;

ENTITY Practica7FBD IS
	PORT (
		clk, reset, stop  : IN std_logic;
		dato_motor        : OUT std_logic_vector(3 DOWNTO 0);
		Selector               : IN std_logic_vector(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavioral OF Practica7FBD IS

	COMPONENT Divisor IS
		PORT (
			clk   : IN std_logic;
			clkl  : OUT std_logic --una salida de reloj
		);
	END COMPONENT;

	TYPE state IS (inicia, cero, uno, dos, tres, cuatro, cinco, seis, siete); --Agregado 4,5,6,7
	SIGNAL pr_state, nx_state : state;
	SIGNAL clkl : std_logic; --el reloj modificado 
BEGIN
	--Llamado al divisor 
	--U1 : ENTITY work.Divisor(arqDivisor) GENERIC MAP(2000000) PORT MAP(clk, clkl);
	U1: Divisor Port map(clk, clkl);
		PROCESS (reset, clkl)
		BEGIN
			IF (reset = '0') THEN --el resert regresa a 0
				pr_state <= inicia;
			ELSIF clkl = '1' AND clkl'EVENT THEN
				pr_state <= nx_state;
			END IF;
		END PROCESS;
 
		PROCESS (pr_state, stop)
			BEGIN
				IF Selector = "11" THEN
					CASE pr_state IS
 						--Escalera de stop (siguiente paso)
						WHEN inicia => 
							IF stop = '0' THEN
								nx_state <= inicia;
							ELSE
								nx_state <= cero;
							END IF;
 
						WHEN cero => 
							IF stop = '0' THEN
								nx_state <= cero;
							ELSE
								nx_state <= uno;
							END IF;

						WHEN uno => 
							IF stop = '0' THEN
								nx_state <= uno;
							ELSE
								nx_state <= dos;
							END IF;

						WHEN dos => 
							IF stop = '0' THEN
								nx_state <= dos;
							ELSE
								nx_state <= tres;
							END IF;

						WHEN tres => 
							IF stop = '0' THEN
								nx_state <= tres;
							ELSE
								nx_state <= cuatro;
							END IF;
 
						WHEN cuatro => 
							IF stop = '0' THEN
								nx_state <= cuatro;
							ELSE
								nx_state <= cinco;
							END IF;
 
						WHEN cinco => 
							IF stop = '0' THEN
								nx_state <= cinco;
							ELSE
								nx_state <= seis;
							END IF;
 
						WHEN seis => 
							IF stop = '0' THEN
								nx_state <= seis;
							ELSE
								nx_state <= siete;
							END IF;
 
						WHEN siete => 
							IF stop = '0' THEN
								nx_state <= siete;
							ELSE
								nx_state <= cero;
							END IF;
					END CASE;
				ELSE
					CASE pr_state IS
 						--una escalera 
						WHEN inicia => 
							IF stop = '0' THEN
								nx_state <= inicia;
							ELSE
								nx_state <= cero;
							END IF;
 
						WHEN cero => 
							IF stop = '0' THEN
								nx_state <= cero;
							ELSE
								nx_state <= uno;
							END IF;

						WHEN uno => 
							IF stop = '0' THEN
								nx_state <= uno;
							ELSE
								nx_state <= dos;
							END IF;

						WHEN dos => 
							IF stop = '0' THEN
								nx_state <= dos;
							ELSE
								nx_state <= tres;
							END IF;

						WHEN tres => 
							IF stop = '0' THEN
								nx_state <= tres;
							ELSE
								nx_state <= cero;
							END IF;
 
						WHEN OTHERS => 
							IF stop = '0' THEN
								nx_state <= inicia;
							ELSE
								nx_state <= cero;
							END IF;
 
					END CASE;
				END IF;
			END PROCESS;
 
			PROCESS (pr_state)
				BEGIN
					IF Selector = "01" THEN --ahora depende de los switchs
						CASE pr_state IS
							WHEN inicia => dato_motor <= "0000";
							WHEN cero => dato_motor <= "1000";
							WHEN uno => dato_motor <= "0100";
							WHEN dos => dato_motor <= "0010";
							WHEN tres => dato_motor <= "0001";
							WHEN OTHERS => NULL;
						END CASE;
					END IF;
 
					IF Selector = "10" THEN
						CASE pr_state IS
							WHEN inicia => dato_motor <= "0000";
							WHEN cero => dato_motor <= "0001";
							WHEN uno => dato_motor <= "0010";
							WHEN dos => dato_motor <= "0100";
							WHEN tres => dato_motor <= "1000";
							WHEN OTHERS => NULL;
						END CASE;
					END IF;
 
					IF Selector = "11" THEN
						CASE pr_state IS
							WHEN inicia => dato_motor <= "0000";
							WHEN cero => dato_motor <= "1000";
							WHEN uno => dato_motor <= "1100";
							WHEN dos => dato_motor <= "0100";
							WHEN tres => dato_motor <= "0110";
							WHEN cuatro => dato_motor <= "0010";
							WHEN cinco => dato_motor <= "0011";
							WHEN seis => dato_motor <= "0001";
							WHEN siete => dato_motor <= "1001";
							WHEN OTHERS => NULL;
						END CASE;
					END IF;
 
				END PROCESS;

END Behavioral;