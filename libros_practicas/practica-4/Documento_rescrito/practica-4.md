```
Práctica 4 Diseño del control de servomotores
```

## Objetivo

El alumno aprenderá la manera de organizar uno proyecto de manera modular y separarlo en diferentes archivos, con la finalidad de que vaya construyendo su propia biblioteca de módulos funcionales, y pueda reutilizar los módulos generados en otros proyectos.

## Especificaciones

Diseñar el control de un servomotor de modelismo utilizando en un FPGA , en le cual por medio de cuatro interruptores de presión tipo push-buton, se pueda controlar la posición del eje del motor. Dos de los interruptores permitirán llevar el eje de cada una de las posiciones extremas, mientras que los otros permitirán  que el motor gire en cada dirección avanzando paso a paso a través de 12 posiciones defindas cada vez que el interruptor es presionado. La determinación de la posición se hará por medio de una señal PWM. La figura 4.1 muestra el diagrama del bloque de este sistema.

## Diagrama de bloques

[[img]]

En la elaboraciòn de un proyecto basado en un FPGA, comúmente se desarrollan gran cantidad de módulos funcionales para manejar las tareas necesarias en esa aplicación. Una buena práctica de diseño es la de utilizar cada uno de esos módulos de manera independiente, ya que esto simplifica el proceso de diseño y permite distribuir las diferentes tareas entre varios grupos de trabajo. Además, si se hace una buena divisón de tareas, al final se contará con un conjunto de módulos funcionales que eventualmente podrán ser reutilizadas en otros proyectos. De esta manera , al aplicar esta métodologia de diseño, el alumno podrá ir construyendo de su propia biblioteca de módulos funcionales, lo que en el futuro le permitirá reducir los timepos de diseño al utilizar estos módulos . Esto implica que cada módulo funcional debe setar contenido en un archivo diferente.

Para el desarrollo de esta práctica se aplicarár este concepto de divisón en módulos funcionales, cada uno de ellos contenidos en un archivo diferente, que posteriormente son integrados en un sólo proyecto al ser instanciados en el módulo principal. La figura 4.2 muesta los bloques funcionales que componen al control de servomotor.

[[igm]]

Para la elaboración de este proyecto, se diseñara dos módulos funcionales de aplicación genérica. el módulo Divisor y el módulo PWM, que podrán ser los dos primeros módulos funcionales de la biblioteca del alumno, además de módulo principal dedicado a la aplicación específica del control del servomotor controlado por cuatro interruptores, en donde se instanciarán los dos módulos de uso general.

El primer módulo para diseñar es el correspondiente al divisor, el cuál generará, a partir de la señal de reloj de 50 [MHz] de la tarjeta de desarrollo, una señal de salida cuya frecuencia corresponde a dividir la señal de entrada, entre un potencia de 2. La frecuencia de salida estará definida por el valor de la constante N. En la figura 4.3 muestra el código para este módulo , el cual estará contenido en el archivo  divisor.

[[code]]

El siguiente módulo es que se encargará de generar una señal PWM. El ciclo de trabajo de la señal generada estará definido por el valor D, el cual tiene una resolución de 256 niveles, con una frecuencia correspondiente a 256 ciclos de reloj de entrada. La figura 4.4 muestra el código para el módulo PWM , el cual estará contenido en el archivo PWM.

[[img]]

Los dos módulos anteriores formarán parte de la biblioteca de módulos  funcionales de alumno, los cuales puede ser utilizados en cualquier otro proyecto en donde se requiera hacer una división de frecuencia o donde se requiera una señal PWM.

Finalmente, el módulo principal de esta aplicación se encargará de detectar la actividad en los interruptores y a partir de ello definir el ciclo de trabajo de la señal PWM. Hay que recordar que un servomotor el modelismo típico se requiere que la señal de control tenga un período de 20ms, y que el ancho de pulso varíe en el rango de 1 a 2 ms, en donde el ancho del pulso determina la posición del eje del servomotor; este módulo debe asegurar que esto se cumpla. Por ello se eligió el bit 11 en el divisor de frecuencia, para tener en 256 ciclos aproximadamente los 20ms. El ancho del pulso de salida variará en el rango de 13 a 24 ciclos para tener el rango de 1 a 2 ms. Con esto el servomotor tendrá 12 posiciones que podrá adoptar en su recorrido. La figura 4.5 muestra el código para el módulo Servomotor, el cual estará contenido en el archivo servomotor.

[[code]]

## Activades complementarias

1. Siguiendo la metodología de diseño presentada, el alumno elaborará un módulo funcional genérico para controlar un servomotor de modelismo, que complementará la biblioteca de módulos del alumno.
2. Utilizando el módulo genérico para controlar un servomotor diseñado en el punto anterior, construir un sistema de haga que dos servomotores de modelismo se muevan de forma complementaria, es decir, se moverán de la misma forma, pero girando en dirección opuesta.
3. Utilizando el módulo genérico para controlar un servomotor diseñado en el primer punto, construir un sistema que haga que dos servomotores de modelismo se muevan independientemente, cada uno de ellos controlado por dos interruptores de presión tipo push-boton, que al presionarlos harán avanzar o retroceder al eje del motor. 
