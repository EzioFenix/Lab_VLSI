```
Practica: 13 Captura de imágenes de cámara digital
```

## objetivos

El alumno aplicará los conocimientos y habilidades obtenidas en el manejo de la señalizacion VGA, para definira una unidad de control de una camará digital. Aprenderá además la señalizacion requerida en el almacenamiento de imágenes digitales de una FPGA.

# introducción

La cámara digital 0V7670 captura de 649x480 pixeles. Opera a 3.3V aunque cuenta con un regulador que permite polarización de hasta 5V. El formato de salida de video, por defecto es el YUV (4:2:2), aunque puedas generar RGB 4:2:2 y RGB565/555/444. El protocolo de comunicación de la cámara es el SCCB, compatible con el protocolo de comunicación 12C (Inter Integrated Circuits). La cámara incluye un módulo para el control del color, de la saturación, del tinte, de gama y de realizado de bordes, entre otros. Éstos deben ser configurados escribiendo los valores adecuados en los registros correspondientes.

La cámara opera por default en formato YUV 4:2:2 de 640x480. De la señal entregadá por la cámara, solamente se recupera componente de iluminancia y esta componente alimenta a un monitor con entrada VGA, dependiendo de la capacidad del FPGA es la cantidad de bits que define la componente de luminancia.

La imagen que entrega la cámara es almacenada es una memoria de doble puerto (escritura y lectura) dentro de FPGA. La figura 13.1 muestra la cámara 0V7670 y el kit de desarrollo.

[code]

# Especificaciones

Utilizando una camára digital, un Fpga y un monitor de entrada VGA, almacenar las imágenes dentro del FPGA con el fin de mostrarlas en un monitor. La figura 13.2 muestra el diagrama de bloques del sistema de captura de imagenes de cámara Digital.



# Diagrama de bloques

{oimg}

El diagrama a bloques  funcionales del sistema capura de imágenes de cámara digital es mostrado en la figura 13.3.



{img}

Como puede observarse en el diagrama se requiere diseñar cinco bloques funcionales dentro del FPGA. A cada uno los llamaremos módulo, siendo los más importantes los de los Captura_pixel y VGA_controller.

El módulo Captura_pixel, se encarga de caputrar la información YUV de cada pixel. Entonces se separa la componente de luminancia. Se calcula una dirección de memoria almacenar únicamente este componente de luminancia correspondiente a cada pixel.

El módulo llamado VGA_controller, se encarga de generar las señales de sincronía para el monitor VGA. Generar las direcciones de memoria para lectura de los valores de pixel: sólo señal RGB para el monitor VGA.

La figura 13.4 muestra las terminales de la cámara, su tipo y descripción de cada una de ellas.

{img}

La figura 13.5 muestra el diagrama de tiempos de las señales de sincronización recibidas por la cámara digital.

[img]

La señal "VSYNC" es indicativa de cada cuadro de imagen. La señal "HREF" enmarca la información de cada pixel.

La cámara entrega, por defecto, una señal YCbCr en formato 4.2.2. Este formato implica que se envía completo el plano "Y" en tanto que los planos de color Cb y Cr se envían submuestreados en un factor de dos. La figura 13.6 ilustra este formato. En esta figura  se observa que por cada pixel es enviada una pareja de componentes CbY ó una pareja CrY. Cada componente requiere de un byte para su representación.

La frecuencia de reloj con el cual, la cámara entrega datos, en formato YCbCr, es el doble de la frecuencia con la que se alimenta la cámara.

[img]

La figura 13.7 muestra a detalle el diagrama de tiempos con la cual la cámara envia bytes de datos. Nótese que la cámara opera en el flanco negativo de la señal de reloj.

[img]

Adicionalmente, se debe mencionar que la cámara debe alimentarse con una señal de reloj de 25Mhz, debido a que provee 30 cuadros por segundo.

Dado que no va enviar datos a la cámara, las señales de comunicación **SIOD** y **SIOC** pueden dejar abiertas o bien , en "1".

La cámara viene pre configurada para proveer una  salida  en formato YUV 4:4:2, en particular, cada línea de imagen se suminirstra en  la secuencia Y,V,Y,U.

Cada componente de color está compuesto por un byte. Se sigue el formato "litle endian", es decir, el bit menos significativo D(0) es enviado primero y el bit más significativo D(7) es enviado al final.

La figura 13.7 muestra detalle el diagrama de tiempos con la cual la cámara envía bytes de datos. Nótese que la cámara opera en el flanco negativo de la señal de reloj.

[img]

Adicionalmente, se debe mencionar que la cámara debe alimentarse con una señal de reloj de 25MHz, debido a que provee 30 cuadros por segundo.

Dado que no se va enviar datos a la cámara, las señales de comunicación **SIOD** y **SIOC** pueden dejarse abiertas o bien, en "1".

La cámara viene pre configurada para proveer una salida en formato  YUV 4:2:2, en particular, cada línea de imagen se suministra en la secuencia Y,V,Y,U.

Cada componente de color está compuesta por un byte. Se sigue el formato "little endian" es decir, el bit menos significativo D(0) es enviado primero y el bit más significativo D(7) es enviado al final.

La figura 13.8 la entidad del sistema Captura de imágenes de cámara digital en un FPGA.

[code]

Las constantes usadas en el programa corresponden a la constantes que se requieren para manipular el monitor con entrada de puerto VGA. La figura 13.9 muestra la declaración de dichas constantes.

[code]

Se diseñara un módulo VRAM, con el fin de tener dos puertos síncronos de acceso. Ambos puertos tienen relojes independientes. La finalidad de tener dos puertos es para evitar el diseño de una cola para las peticiones de acceso (lectura y escritura) un chip RAM. El código de la memoria es mostrado en la figura 13.10.

[code]

La razón  de esta memoria está en que la cámara maneja su propia señalizacion para enviar datos.

[code ]

[code]

Finalmente, la unión de todos los códigos antes mencionados se muestra en la figura 13,14.

[code]

[code]

[code]

[code]

[code]

## Actividades complementarias

El alumno investigará:

1. El funcionamiento de los sistemas de imágenes BAYER, FIVEON X3.
2. El modelo de color YUV.
3. Cuántos detectores de luz de color rojo, de color verde y de color azul hay en el ojo humano.
4. El alumno investigará el tamaño de imagen que captura la cámara de su teléfono celular.
5. El significado de binarización de imágenes.