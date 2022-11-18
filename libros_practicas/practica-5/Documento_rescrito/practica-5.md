```
<<<<<<< HEAD
Practica 5 Diseño del control de intensidad en leds
```

## Objetivo

El alumno aprenderá a diseñar módulos con parámetros genéricos, lo que permitirá crear un proyecto con varias instancias de un mismo elemento pero con diferentes caraterísitcas de operación, con el fin de dar una mayor versatilidad a los módulos diseñados por el alumno.

## Especificaciones

Diseñar el cirucuito utilizando un FPGA que se encargue de controlar el encendido de cuatro LEDs, cada uno de los cuales encenderá con diferente intensidad. La intensidad de cada LED será controlada por medio del ciclo de trabajo de una señal PWM. Las luces en los LEDs irán cambiando siguiendo una secuencia determinada. La figura 5.1 muesta el diagrama de bloque de este sistema.

## Diagrama de bloques

[[igm]]

Al realizar un diseño utilizando un FPGA es común que se requiera tener funcionando concurremente varias copias de un mismo objeto, y en muchas ocasiones cada copia del objeto deberá tener características de operación diferente. Por ejemplo, en un mismo diseño se puede requerir utilizar varios registros similares, per9o de diferente tamaño. No sería práctico tener en una biblioteca una versión del mismo registro para cada tamaño posible. Lo conveniente en este caso, es tener una sola definición del registro en el que se pueda definir el tamaño del mismo cuado sea creada una instancia de él. Esto se puede lograr con el uso de paramétros genéricos.

En esta  práctica se utlizarán los bloques funcionales diseñados en la práctica anterior, cerrando varias instancias de cada uno, pero se modificará uno de los módulos para que utilice un paramétro genérico. En la figura 5.2 muestran los bloques funcionales que integran este diseño.

[[img]]

Como se observa en el diagrama , se utilizarán cuatro instancias del módulo PWM y dos del módulo Divisor. Hay que notar que se requiere utilizar dos divisores de frecuencia, yaq ue se tienen dos procesos que utilizan relojes con frecuencia diferente, uno de frecuencia alta para genera la señal PWM que se utilizará para encender los LEDs, y otro de frecuencia menor que señalará los tiempos en que cambia el estado de la secuencia que se observará en cada LED. La figura 5.3 muesta el código  para el módulo diviro que estará contenido en el archivo diviro, en el que ha cambiado la definición del valor N, siendo ahora un parámetro genérico en lugar de una constante.

[[code]]

Para el caso del módulo PWM no es necesario realizar modificación alguna el código de la práctica anterior, por lo que aquí se reutilizará directamente el módulo previamente construido y que forma parte de la biblioteca de módulos del alumno.

Ahora sólo falta construir el módulo principal, el cual se encargará de generar la secuencia que observará en los LEDs. La figura 5.4 muestra el código para el módulo Leds, el cual iría contenido en el archivo leds. Para probar el funcionamiento de estar práctica se utlizarán los LEDs de la tarjeta de desarrollo.

Es importante notar el código que para cambiar la asignación de intensidadades no es necesario utilizar una variable auxiliar para evitar la pérdida de los valores, ya que aquí
=======
Practica 5. Diseño del control de intensida
```

# Objetivo:

El alumno aprenderá a diseñar módulos con parámetros genéricos, lo que permitirá crear un proyecto con varias instancias de un mismo elemento pero con diferentes características de operación con el fin de dar mayor versatilidad a los módulos diseñados por el alumno.

# Especificaciones

Diseñar un circuito utilizando un FPGA que se encargue de controlar el encendido de cuatro LEDs cada una de los cuales encederá con diferente intensidad. La intentsidad de cada LED será controlada por medio del ciclo de rabajo de una señal PWM. Las luces  en los LEDs  cambiando  siguiendo una seucnecia determinada. La figura 5.1 muestra el diagrama del bloque de este sistema.

>>>>>>> fce2066b44ab50a58b83b4d5b4ffdffdbd8284f8
