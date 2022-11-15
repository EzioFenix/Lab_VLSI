```
Practica: Diseño del control de motores a pasos
No: 6
```

# Objetivo

El alumno aprenderá a diseñar el controlador de un motor a pasos mediante el uso e implementación de maquinas de estado.

## Especificaciones

Diseñar el circuito de control  utilizando una FPGA, el cual se encargue de activar un motor a pasos bipolar con 4 líneas de control. Los movimientos que debe realizar el motor son en sentido a las manecillas del reloj, viceversa y detenido por medio de tres botones que controlan estos movimientos.

La figura 6.1 muestra el diagrama de bloques del sistema.

## Diagrama de bloques

[[img]]

## Tabla de estados

La figura 6.2, muestra la tabla de estados, la cual está diseñada con 11 estados que inician en el estado SMO hasta el estado SM10. Por la cantidad de condiciones de entrada y estado está expresada por colores para cada estado, para una mejor compresión. En la figura 6.2. A se observa el Estado 0, Estado 1, Estado 2 y Estado 3. En la figura 6.2B se observa el Estado 4, Estado 5, Estado 6 y Estado 7. En la figura 6.2C se observa el Estado 8, Estado 9 y Estado 10.

[[img]]



[[img]]



```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity motpasos is
	port(reloj : in std_logic;
	ud: in std_logic;
	rst: in std_logic;
	fh: in std_logic_vector(1 downto 0);
	led: out std_logic_vector(3 downto 0);
	mot: out std_logic_vector(3 downto 0));
end motpasos;

architecture behavioral of motpasos is
	signal divi: std_logic_vector(17 downto 0);
	signal clks: std_logic;
	type estado is(sm0,sm1,sm2,sm3,sm4,sm5,sm6,sm7,sm8,sm9,sm10);
	signal pres_S, next_s: estado;
	signal motor: std_logic_vector(3 downto 0);
begin
```

En la figura 6.4 se observa el código del bloque Divisor de frecuencia.

```vhdl
process( reloj, rst)
begin
	if rst='0' then
        div <= (others=>'0');
    elsif reloj'event and reloj='1' then
        div <=div +1;
   end if;
end process;
clks <= div(17);
      
```

En la Figura 6.5 se observa el código de las transiciones de estados.

```vhdl
process (clks,rst)
begin
	if rst='0' then
		pres_s <= sm0;
	elsif clksm	'event and clks='1' then
	end if;
end process;

process (press_s, ud,rst,fh)
begin
	case(press_s) is
		when sm0 => --estado 0
			next_s <=sm1;
		when sm1 => --estado 1
			if fh ="00" then --motor bipolar
		if ud='1' then
			next_s<=sm3;
		else
			next_s <=sm7;
		end if;
	elsif fh="01" then
		if ud='1' then
			next_s <= sm8;
		end if;
	elsif fh="10" then
		if ud='1' then
			next_s <= sm2;
		else
		next_s <= sm8;
	end if;
	elsif fh="11" then
		if ud='1' then
			next_s <= sm9;
		else
		next_s <=sm4;
	end if;
else
	next_s<= sm1;
end if;
when sm2 =>
	if fh ="00" then
		if ud='1' then 
			next_s <= sm1;
		else
			next_s <=sm7;
```

```vhdl

```



```vhdl
elsif fh="10" then
    if ud='1' then
        next_s <= sm1;
   else
       next_s <=sm8;
    end if;
elsif
```



```vhdl
process(pres_s)
begin
	case pres_S is
		when sm0 => motor <="0000";
		when sm1 => motor <="1000";
		when sm2 => motor <="1100";
		when sm3 => motor <="0100";
		when sm4 => motor <="0110";
		when sm5 => motor <="0010";
		when sm6 => motor <="0011";
		when sm7 => motor <="0001";
		when sm8 => motor <="1001";
		when sm9 => motor <="1010";
		when sm10 => motor <="0101";
		when others => motor <="0000";
	end case;
end process;

mot<= motor;
led<= motor;

end behavioral;
```



## Actividad complementaria

El alumno deberá realizar las modificaciones pertinentes para poder girar el motor las vueltas necesarias que representen los dígitos de su número de cuenta,s e deben combinar los giros horarios, antihorario y detenido.
