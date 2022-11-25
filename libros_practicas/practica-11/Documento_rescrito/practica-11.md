```
Práctica 11. Emulador de display 7 segmentos en monitor
```

## Objetivo

El alumno diseñara un emulador de display 7 segmentos empleando de FPGA y un monitor VGA.

## Especifiaciones

Utilizando un FPGA, un cable y un monitor con entrada  sea un número binario de cuatro bits y su salida sea la visualización de este número en un display de 7 segmentos en un monitor.

La figura 11.1 muestra el diagrama de bloques del sistema y la figura 11.2 muestra los bloques funcionales requeridos en el sistema Emulador de Display 7 segmentos en monitor.

# Diagrama de bloques

[[img]]

## Diagrama de bloques funcionales

[[img]]

La entidad del sistema emulador de display 7 segmentos en monitor se muestra en la figura 11.3.

[code]

Se requiere un caso por caso por cada número que se desee visualizar en el monitor, cada caso corresponderá a un cuadro de imagen diferente. Todos los casos se deben declarar en el proceso generador de imagen. La figura 11.4 muestra la declaración de constantes.

[[code]]

El decodificador BCD a 7 segmentos se declara dentro de la arquitectura, como se muestra en la figura 11.5.

[[code]]

Respecto al display de 7 segmentos, la figura 11.5 muestra la asignación de cada segmentos con sus respectiva coordenadas.

[[img]]

Por ejemplo, para que aparezca el número '1'  deberá activarse el segmento B (color:verde) y C (color:rojo). La figura 11.8 , muesta el código para visualizar los números uno y dos.

[[code]]

Para visualizar el número nueve se deben activar los bloques A,B,C,F y G.  La figura 11.9 muestra el código requerido.

[[code]]

## Actividad complementaria

En esta práctica se mostró como codificar para que se emulen los números 1,2 y 9 en la pantalla VGA. El alumno implementará además los números 0,3,4,5,6,7 y 8.