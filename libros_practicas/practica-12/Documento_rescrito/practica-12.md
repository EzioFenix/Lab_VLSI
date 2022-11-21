```
Práctica 12 emulador de contadores en un monitor
```

## Objetivo

El alumno aprenderá el diseño de contadores mediante un FPGA y con visualización en un monitor VGA.

## Especificaciones

Utiliza un FPGA, un cable VGA y un monitor, diseñar un contador que cuenta del cero al nueve. Cuando el conteo llegue a su limite, el contador deberá reiniciarse. La figura 12.1 muestra el diagrama de bloques y la figura 12.2 muestra los bloques funcionales de sistema emulador de contadores en un monitor.

## Diagrama de bloques 

[[img]]

## Diagrama de bloques funcionales

[[img]]

El proceso del divisor de frecuencia se muestra en la figura 12.3, donde puede observarse la entrada de reloj de 50 mHz y a su salida la señal de reloj "clklow" a muy baja frecuencia.

[[img]]

La figura 12.4 muestra la declaración  de constantes y la máquina de estados requerida para la obtención del contador de cuatro bits.

[[img]]

El proceso del divisor de frecuencia se muestra en la figura 12.3, donde puede observase la entrada de reloj de 50 mHz y a su salida la señal de reloj "clklow" a muy baja frecuencia.

[[img]]

La figura 12.4 muestra la declaración de constantes y la máquina de estados requerida para la obtención del contador de cuatro bits.

[[code]]

[[code]]

## Actividad complementaria

Diseñar un contador binario descendente con visualización en un monitor VGA. Cuando el contador llegue a su limite de cuenta, éste deberá reiniciarse.