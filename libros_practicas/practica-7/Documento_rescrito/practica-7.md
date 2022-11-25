```
Práctica de control de sensores de ultrsónico
```

# Objetivo

El alumno aprenderá a diseñar mediante la utilización de atributos a señales('HIGH') y tipos de variables (UNSIGNED) eñ cpmtrpñ de un sensor ultrasónico (HC-SR04).

# Especificaciones

Diseñar un circuito controlador utilizando un FPGA que se encargue de calcular la distancia de un obstáculo por medio de un sensor ultrasónico (HC-SR04). y observar los resultados de distancia por medio de 2 displays de 7 segmentos. La figura 7.1 muestra el diagrama bloques del sistema.

# Diagramas de bloques 

[[img]]

Las siguientes figuras muestran el código del control para el sensor ultrasónico, que estará contenido en el archivo sónicos. El código fue separado, para su mejor compresión, de acuerdo con el diagrama a bloques mostrado.



La figura 7.4 se observa el código de los bloques calculador de distancia y contador de pulsos.

[[code]]

La figura 7.5 muestra el código para la decodificación de datos a dos displays de siete segmentos; este código esta diseñado para utilizar displays de ánodo común.

[[code]]

## Actividad complementaria

El alumno deberá realizar las modificaciones pertinentes para poder detectar de distancia exacta propuesto por el profesor de un objeto, cuando sea detectada deberá poner la letra S (stop) en un display de 7 segmentos, la cual indica que no puede acercarse más o chocará con el objeto.