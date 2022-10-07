---
marp: true
paginate: true
style: |
  section {
    font-size: 30px;
  }
  h1 {
    color:orange;
    text-align: center;
    background-color:black;
  }
  section::after {
  font-weight: bold;
  background-color:black;
  color:orange;
  font-size: 25px;
  padding: 5px;
  }
---
<!-- _backgroundColor: Orange -->
<!-- _color: white-->

# Presentador: Victor Miguel Barrera Peña
## Práctica 4:

---

# Actividad

1. Elaborar un programa el cual consiste en un “candado electrónico”,
donde se tendrá que ingresar un password mediante el teclado
matricial, el password debe contener 4 valores (seleccionados por el
programador), los cuales deben de observarse en 4 de displays de 7
segmentos. Cuando se ingrese el password correcto se deberá indicar
mediante la activación de un led y puede permanecer activado hasta
que se ingrese nuevamente otro password. Para la elaboración del
programa, se considerará el plantamiento de una máquina de estados
que permita ir colocando de forma desplazada cada uno de los dígitos y una vez que se tengan los cuatro dígitos en los displays se procede a detectar el password correcto, todo se llevará a cabo de manera secuencial.

---

# Idea de solución

- Implementar teclado 4x4.
- Implementar un display de 7 segmentos.
- Implmentar un máquina de estados con estado inicial, final, reset y un estado de aceptación.
- Implementar antirebote.

---

# Diagrama de estados

![](img/Mesa%20de%20trabajo%201.png)
- Es de tipo mealy

---

## Explicación

- **X** es cualquier entrada
- $A_1$ es el primer carácter, ya que la contraseña es $A_1,A_2,A_3, A_4$ en ese orden, introducirlas de manera correcta es necesario.
- $\overline{A_n}$ es todo aquello que no sea $A_n$.
- El estado final esta en rojo y sólo se acepta cuando la secuencia es correcta.
- Es una máquina de tipo mealy.

---

# Cambios en el código original

- Se agregó  un display de 7 segmentos (sólo muestra el último caracter introducido).
- Se módifico el código de estado.
- No funciona en quartus 17.1, sino parapaderán aletoriamente los led.


---

# Veamos su comportamiento

---

# Muchas gracias por ver el video


![bg left:70%](./img/end.jpg)