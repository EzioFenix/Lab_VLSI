```
Práctica 3
Diseño del control de un tren eléctrico
```

# Objetivo

Demostrar a los estudiantes la forma de declarar tipos de datos diferentes a los definidos en el lenguaje VHDL mediante el diseño del sistema de control de un tren eléctrico.

# Especificaciones

Diseñar un sistema digital que moverá un tren de derecha a izquierda y viceversa, sobre una línea, deteniéndose en cada estación por 2 minutos. En cada una hay sensores que detectan cuando un tren entra a la estación. Existe un botón de emergencia en los vagones que hará que el tren se detenga por un minuto de más en la estación, si así se requiere.

En la figura 3.1 se muestra el diagrama de bloques del sistema Tren eléctrico.

# Diagrama de bloques

[[img]]

La figura 3.2 muestra los bloques funcionales dentro del FPGA del sistema tren eléctrico y en la figura 3.3 se muestra su carta ASM.

# Bloques funcionales

[[img]]

La figura 3.4 muestra la entidad del sistema tren eléctrico.

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all
use IEEE.std_logic_unsigned.all;

entity tren is
	port(
		reloj,alto,sa,sn,emergencia,estacion : in std_logic;
		alto1,alto2,este,oeste,reset_FF1 : std_logic
	);
end tren;
```

La figura 3.5 muestra la parte declaratoria de la arquitectura en el sistema tren eléctrico.

```vhdl
architecture behavioral of tren is
	signal segundo: std_logic;
	type estados is (s1,s1);
	signal epresente,esiguiente: estados;
```
La figura 3.6 muestra la parte operatoria en la arquitectura en el sitema tren eléctrico.

```vhdl
begin
	proces(reloj)
	begin
		if rising_edge(segundo) then
			epresente <= esiguiente;
		end if;
	end process;
	
	process (epresente,estacion,alto,emergencia,sa,sn)
	begin
		case epresente is
			when s0 =>
				if estacion ='1' then
					alto2 <='1';
					esiguiente <=s1;
```



```vhdl
    else
        esiguiente <= s0;
    end if;
    when s1 =>
        if alto = '1' then
            esiguiente <= s1;
        elsif emergencia ='1' then
            reset_FF1 <= '1';
            alto <='1';
            esiguiente <=s1;
        elsif sa='1' then
            oeste <= '1';
            esiguiente<= s0;
        elsif sn='1' then
            este <='1';
            esiguiente <=s0;
        elsif esiguiente <=s0;
        end if;
    end process;
end behavioral;
```



# Actividad complementaria

El alumno diseñará un sistema que controle la apertura y cierre de un puente en el cruce de barcos que van de norte a sur y viceversa, y de autos de van desde este a oeste y viceversa.

Los barcos tienen preferencia, por lo que se requiere que el sistema manipule sensores con el fin de que cuando se detecte un barco, se envié una señal a unos semáforos que pasen de la luz verde, a la amarilla y luego a la roja. Cuando el barco ya no se encuentre cerca del puente, la luz roja se apagará y se encenderá la verde.

Al mismo tiempo que se active el detector de barcos, se activará una señal sonora para que los conductores distraídos pongan atención al cambio de luces en los semáforos y se empiece abrir el puente dando paso a los barcos.
