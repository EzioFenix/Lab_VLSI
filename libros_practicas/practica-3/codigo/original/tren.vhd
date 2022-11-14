LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY tren IS
	PORT (
		reloj, alto, sa, sn, emergencia, estacion : IN std_logic;
		alto1, alto2, este, oeste, reset_FF1 : out std_logic
	);
END tren;

ARCHITECTURE behavioral OF tren IS
	SIGNAL segundo : std_logic;
	TYPE estados IS (s0, s1);
	SIGNAL epresente, esiguiente : estados;

BEGIN
	process(reloj) 
	BEGIN
		IF rising_edge(segundo) THEN
			epresente <= esiguiente;
		END IF;
	END PROCESS;
 
	PROCESS (epresente, estacion, alto, emergencia, sa, sn)
	BEGIN
		CASE epresente IS
			WHEN s0 => 
				IF estacion = '1' THEN
					alto2 <= '1';
					esiguiente <= s1;

				ELSE
					esiguiente <= s0;
				END IF;
			WHEN s1 => 
				IF alto = '1' THEN
					esiguiente <= s1;
				ELSIF emergencia = '1' THEN
					reset_FF1 <= '1';
					alto1 <= '1';
					esiguiente <= s1;
				ELSIF sa = '1' THEN
					oeste <= '1';
					esiguiente <= s0;
				ELSIF sn = '1' THEN
					este <= '1';
					esiguiente <= s0;
				ELSE esiguiente <= s0;
				END IF;
		END CASE;
	END PROCESS;
END behavioral;