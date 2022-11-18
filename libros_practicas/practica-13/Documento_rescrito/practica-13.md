```
Practica: 13 Captura de imágenes de cámara digital
```

## objetivos

El alumno aplicará los conocimientos y habilidades obtenidas en el manejo de la señalizacion VGA, para definira una unidad de control de una camará digital. Aprenderá además la señalizacion requerida en el almacenamiento de imágenes digitales de una FPGA.

# introducción

La cámara digital 0V7670 captura de 649x480 pixeles. Opera a 3.3V aunque cuenta con un regulador que permite polarización de hasta 5V. El formato de salida de video, por defecto es el YUV (4:2:2), aunque puedas generar RGB 4:2:2 y RGB565/555/444. El protocolo de comunicación de la cámara es el SCCB, compatible con el protocolo de comunicación 12C (Inter Integrated Circuits). La cámara incluye un módulo para el control del color, de la saturación, del tinte, de gama y de realizado de bordes, entre otros. Éstos deben ser configurados escribiendo los valores adecuados en los registros correspondientes.

La cámara opera por default en formato YUV 4:2:2 de 640x480. De la señal entregadá por la cámara, solamente se recupera componente de iluminancia y esta componente alimenta a un monitor con entrada VGA, dependiendo de la capacidad del FPGA es la cantidad de bits que define la componente de luminancia.

La imagen que entrega la cámara es almacenada es una memoria de doble puerto (escritura y lectura) dentro de FPGA. La figura 13.1 muestra la cámara 0V7670 y el kit de desarrollo.



# Especificaciones

Utilizando una camára digital, un Fpga y un monitor de entrada VGA, almacenar las imágenes dentro del FPGA con el fin de mostrarlas en un monitor. La figura 13.2 muestra el diagrama de bloques del sistema de captura de imagenes de cámara Digital.



# Diagrama de bloques

{oimg}

El diagrama a bloques  funcionales del sistema caputa de imágenes de cámara digital es mostrado en la figua 13.3.



{img}

Como puede observarse en el diagrama se requiere diseñar cinco bloques funcionales dentro del FPGA. A cada uno los llamaremos módulo, siendo los más importantes los de los Captura_pixel y VGA_controller.

El módulo Captura_pixel, se encarga de caputrar la información YUV de cada pixel. Entonces se separa la componente de luminancia. Se calcula una dirección de memoria almacenar únicamente este componente de luminancia correspondiente a cada pixel.

El módulo llamado VGA_controller, se encarga de generar las señales de sincronía para el monitor VGA. Generar las direcciones de memoria para lectura de los valores de pixel: sólo señal RGB para el monitor VGA.

La fiugra 13.4 muestra las terminales de la cámara, su tipo y descrpción de cada una de ellas.

{img}