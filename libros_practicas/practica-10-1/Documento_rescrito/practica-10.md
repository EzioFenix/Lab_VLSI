```
practica 10 Diseño de un generador de video vGA
```

# Objetivo

El alumno aprenderá los principios de la señalización para generar video en formato VGA.

Así como la implementación en un FPGA.

# Especificaciones

Utilizando un FPGA, un cable y pantalla VGA, se programará el controlador de video VGA, con la finalidad e proyectar una imagen estática.

Como se observa en el diagrama de bloques de la figura 10.1, el sistema tiene una entrada de reloj, y cinco salidas `h_sync`, 

# Diagrama de bloques

[[img]]

Como se observa en el diagrama de bloques funcionales de la figura 10.2, el sistema cuenta con cuatro bloques funcionales.

## Diagrama de bloques funcionales

[[img]]

## Introducción

El VGA es un estándar de gráficos hecho por IBM en la década de los 80s. VGA es un adaptador gráfico de video, con una resolución de 640x480.

Una señal de video VGA contiene 5 señales actividades:

- Dos para sincronizar video : Sincronización horizontal (h_sync) y  Sincronización vertical (v_sync).
- Tres para asignar color: Rojo (R), Verde (G), Azul (B).

El formato VGA permite que se vean imágenes y video en un monitor, el video desplegará la emulación de movimiento con imágenes mostradas a una determinada velocidad. Las imágenes deben estar contenidas en un cuadro visible de 640x480 pixeles, que a su vez debe estar dentro de otro cuadro más grande (un margen invisible de derecha a izquierda y de arriba hacia abajo ) de 800 pixeles x 525 líneas.

[[img]]

Los datos que se requieren para programar el control son:

- Frecuencia de actualización; 60hz. Resolución:  640x 480 pixeles. Reloj 25Mhz.
- Parámetros Horizontales => PulsoH=96,BHP=48,PH=640,FPH=16(pixeles).
- Parámetros Verticales=> Pulso V=2,BPV=33,PV=480,FPV=10(líneas)

## Desarrollo 

La figura 10.4 muestra la entidad del sistema de señalización VGA.

[[code]]

Se requiere generar una frecuencia de 25Mhz, lo cual se obtendrá a partir de reloj principal de la tarjeta de desarrollo.  En la figura 10.5 se observa el código de un divisor para obtener la frecuencia mencionada a partir de un reloj de 50Mhz.

[[code]]

Para controlar los tiempos horizontales y las líneas verticales, se requiere de dos contadores, uno horizontal y el otro vertical, El primero va de 0 a 800 y el segundo de 0 a 525. La figura 10.6 muestra el código correspondiente a los procesos requeridos.

[[code]]

Para visualizar el cuadro de imagen en el monitor VGA, se requiere programar en que el renglón y columna inicia y finaliza.

La figura 10.7 muestra las dos condiciones que se requieren para el despliegue de la imagen:

1.-  Que el habilitador de pintura esté el espacio visible.

2.- Colocar en la coordenada el color asignado.

Si la cuenta horizontal (h_count) es menor que 640 y si al mismo tiempo el contador horizontal (v_count) es menor que 480, significa que estamos en el espacio visual y activamos la bandera de habilitación de despliegue (display_ena=1).

[code[]]

Para pintar se tiene 3 colores rojo, verde y azul (en inglés Red,Green,Blue). Cuando: RGB=1,0,0 el color es Rojo, si RGB=0,1,0 el color que desplegará será verde, si RGB=0,0,1 será Azul, si RGB=1,1,1 el color es blanco y si RGB es 0,0,0,0 el color será negro.

La figura 10.8 muestra el proceso habilitador de visualización del sistema adaptador de video VGA.

[[code]]

Se requiere dar valores a las constantes para el manejo del formato VGA, que se declarán dentro de un "generic", la figura 10.8, muestra un ejemplo de estos valores.

[[code]]

Las declaraciones y operaciones de las contstantes tipo señal adicionales, se muestra en figura 10/10.

[code]

## Actividad complementaria

El alumno unirá los distintos procesos en un solo y mostrará sus resultados en un monitor.

# Actividades complementarias del profesor

1. Pintar la bandera LGBT+ hacia abajo con líneas de colores, en el orden que sea.
2. Dibujar un objeto en las 4 esquinas movido con 2 switchs, esta en las fotos de
