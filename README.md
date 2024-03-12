# Tarea 1 - Diseño VLSI
### EL-5807 - Introducción al Diseño de Circuitos Integrados
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/>

## 1. Introducción

En este informe, se abordan dos partes clave en el diseño de circuitos CMOS para el proceso XT018 con módulo LPMOS a 1.8V. En la Parte 1, se determinan las resistencias de canal de transistores NMOS y PMOS de tamaño mínimoa través del uso de dos métodos distintos. Además, se calcula la capacitancia equivalente de compuerta manualmente. En la Parte 2, se diseña un inversor mínimo con margen de ruido simétrico, optimizando la relación PMOS/NMOS. Se evalúan tiempos de retardo y se comparan soluciones manuales con las del optimizador, explorando criterios de rendimiento, potencia y área. Por último, se monta un deck de SPICE de un FO4 para determinar la resistencia efectiva de los transistores CMOS a través de la simulación. 


## 2. Desarrollo

### Parte 1

Para calcular la resistencia efectiva de un transistor de tamaño mínimo de la tecnología del curso, se hizo uso de las ecuaciones provistas en la sección 4.3.7 de [1], las cuales se muestran a continuación

![imagen](https://hackmd.io/_uploads/HkHLswtTp.png)

A continuación, se emplearon los valores de corriente proporcionados en [2] para llevar a cabo el cálculo de las resistencias. Dado que estos resultados dependen del ancho del canal, se adoptaron dimensiones específicas, con un ancho W_ne de 220 nm y un ancho W_pe de 440 nm. La tabla siguiente presenta los resultados obtenidos tanto por la ecuación 4.16 como por la 4.19. 


|Transistor| Parámetro | Según la Ec. 4.16 | Según la Ec. 4.19 |
|:---------:|:---------:|:----:|:-----:|
|NMOS|  R_eff (kohm*um) | 1.89  | 3.79  |
|PMOS|  R_eff (kohm*um)| 5.29  | 10.59  |
|NMOS|  R (kohm) | 8.61  | 17.23  |
|PMOS|  R (kohm) | 12.03  | 24.06 |

De la tabla anterior se puede observar que existe una gran diferencia entre los resultados de las dos ecuaciones. Dado que la resistencia efectiva es inversamente proporcional al ancho del canal, para esta tarea se es pesimista y se sobreestima el ancho del canal de los transistores reales, por lo que se escogen los resultados de la ecuación 4.19.


Ahora bien, para averiguar la constante RC, primero se calculó la capacitancia efectiva de compuerta de cada transistor con la siguiente ecuación

[![ec.png](https://i.postimg.cc/fW7rRgsk/ec.png)](https://postimg.cc/V56R7gdc)

Segun la tabla proporcionada en [2]; Cox es 8.46 fF/um para NMOS y 8.91fF/um para el PMOS, y Cov es 0.33fF/um2 para NMOS y 0.32fF/um2 para PMOS. Ldib es 0.18 y Wdib es 0.22um, para ambos transistores (NMOS y PMOS). Obteniendo los siguientes resultados

![imagen](https://hackmd.io/_uploads/SywkLdK6p.png)



### Parte 2.a

Primero, se creó el esquematico con el tamaño mas pequeño permitido por el mismo Custom Compiler, de donde se obtuvieron los valores de Wne=220nm y Wpe=440nm (suponiendo una relación P/N de 2:1)
[![sch.png](https://i.postimg.cc/6p4hhs20/sch.png)](https://postimg.cc/RW9fMDT6)
Se creó el archivo HSPICE (`mos`)para simular la corriente de saturacion y la linealidad del mismo, con diferentes Vdd. En la siguiente figura se puede apreciar el resultado;



[![curvas-nmos.png](https://i.postimg.cc/Sxj48pQg/curvas-nmos.png)](https://postimg.cc/TK8BMFDb)

Se puede notar que existe una relacion lineal con Vdd y el transistor.

Para determinar el Beta del transistor se utilizó la ecuación;
[![beta.png](https://i.postimg.cc/0Qjjpvr5/beta.png)](https://postimg.cc/XGMnbTwt)

Entonces, para diseñar una curva donde el corte sea justo en Vdd/2, se necesita una relacion de Betan/Betap. Segun los resultados anteriores, Vtn=0,45V y Vtp=0,60
Betan=0.00003518958388317058
Betap = 0.00003527336860670194
La relacion es de 2.5.

Se desarrolló el estudio sobre la curva característica del inversor en hspice, utilizando el archivo `src/parte2/inverter_tf.sp`. Primero, se utilizó el menor ancho permitido por la aplicacion, con un Wne=220nm para el NMOS y un Wpe=440nm para el PMOS. Se describio el ancho del PMOS, siempre como el doble del NMOS. El largo es de L=180nm, para ambos transistores. Este fue el resultado del mismo.

[![w220.png](https://i.postimg.cc/CxtRV6XX/w220.png)](https://postimg.cc/753H3Xxn)

Asimismo, se repitió la simulación para diferentes anchos para estudiar, como cambia la curva. Los cuales se mostraran a continuacion;
#### Para Wne=440nm:

[![w440.png](https://i.postimg.cc/3rnJTcD1/w440.png)](https://postimg.cc/qg6dcQw6)

#### Para Wne=660nm

[![w660.png](https://i.postimg.cc/tT9p03q8/w660.png)](https://postimg.cc/CZrWkff4)

#### Wne=880nm

[![w880.png](https://i.postimg.cc/LXvRmJh5/w880.png)](https://postimg.cc/k6VLcXQP)

#### Wne=1000nm

[![w880.png](https://i.postimg.cc/LXvRmJh5/w880.png)](https://postimg.cc/k6VLcXQP)




****
### Parte 2.

Para realizar la medición de los tiempos de propagación de subida, bajada y promedio se utilizó el SPICE deck mostrado en `src/parte2/parteC/fo4.sp`, donde se puede observar que el ancho de canal para los transistores del inversor son de 220 nm para el NMOS y para PMOS es de 440 nm (relación 2/1). Los resultados obtenidos se muestran en la siguiente tabla

|Parámetro| Valor (ps) | 
|:---------:|:---------:|
|tpdr|  114.5  | 
|tpdf|  75.9 | 
|tpd|  95.26 | 

### Parte 2.b.i

Posteriormente, se desarrolló un script en Python con el propósito de ajustar la relación de anchos PMOS/NMOS de los transistores del inversor, variando dicha relación desde 1 hasta 4, con incrementos de 0.1. El código correspondiente está ubicado en `src/parte2/script_test/fo4_script.py`. Este script realiza la creación del SPICE deck con los nuevos anchos, ejecuta la simulación en la consola y procesa los resultados generados por los archivos `.mt0`, almacenando la información resultante en un nuevo archivo denominado `delays.csv` (que se encuentra en el mismo directorio del script).

Una vez ejecutado el script, se procedió a visualizar los resultados obtenidos mediante la creación de gráficos utilizando la herramienta de Excel. Los gráficos generados se presentan en la siguiente figura.


![imagen](https://hackmd.io/_uploads/rJlqS8KT6.png)

De la figura anterior se obtuvo que cuando la relación PMOS/NMOS es de 2.1, se alcanza un valor mínimo de 95.45 ps para tpd. En cambio, cuando la relación es de 4, la diferencia entre los retardos tpdr y tpdf se reduce a un mínimo de 15.55 ps.

### Parte 2.b.ii


Al ejecutar el SPICE deck de la figura 8.11 de [1] (ubicado en `src/parte2/fo4opt.sp`) y optimizar la relación PMOS/NMOS dadas las condiciones tpd=(tpfr+tpdf)/2=0 y diff=0 se obtuvieron los datos de la siguiente tabla

|Condición| Relación PMOS/NMOS | tpdr (ps) | tpdf (ps) | tpd (ps) | diff (ps) | pwr (mW) |
|:---:|:-------:|:---:|:---:|:----:|:---:|:----:|
|tpd = 0| 2.16 | 113.6| 77.34  |  95.47  | 36.25  |  1.762  |
|diff = 0| 4.0|109.9 |  94.36 | 102.1  |  15.54 |  2.546  |

En la siguiente figura se puede observar la potencia entregada por la fuente para las dos relaciones PMOS/NMOS anteriores

![imagen](https://hackmd.io/_uploads/S1SZFHFaT.png)

Los resultados obtenidos a través del script corroboran la consistencia con los obtenidos mediante el optimizador de SPICE. Se confirma que, dentro del rango de relaciones de anchos PMOS/NMOS de 1 a 4, es imposible lograr la igualdad en los retardos de subida y bajada, así como obtener un retardo promedio nulo.

Desde la perspectiva del área, es evidente que los transistores PMOS de mayor tamaño tienden a consumir una potencia considerable [1]. Esta observación se respalda con la figura y tabla anteriores, donde se aprecia que el inversor con una relación PMOS/NMOS de 4:1 presenta un consumo promedio de potencia de 2.546 mW, superando en 784 uW al inversor con una relación P/N de 2.16:1. Considerando estos términos, la relación P/N de 4:1 se descarta.

Ahora bien, según los resultados obtenidos con el script, las relaciones P/N desde 1.9:1 a 2.3:1 otorgan un retardo de propagación promedio de 95.5 ps (la diferencia entre dichas relaciones es de 100 fs aproximadamente). Entonces no es necesario utilizar exactamente los 2.16:1 que indica el optimizador ni los 2.1:1 obtenidos por medio del script, por lo que la relación de 2:1 se elige como la mejor en términos de consumo de potencia, área y retardo promedio.


### Parte 2.c

Habiendo escogido la relación P/N de 2:1, en esta última parte se realizó la prueba del fan-out de 3 inversores, ya que el fan-out de 4 se había probado al inicio de la parte b, el deck de SPICE utilizado se encuentra en `src/parte2/parteC/fo3.sp`. Los resultados de dichas simulaciones se muestran en la siguiente tabla

| Circuito | tpdr (ps) | tpdf (ps) |
|:-------:|:---:|:---:|
| fo3 | 94.2| 63.0  | 
| fo4| 114.5 |  75.9 |

Al aplicar la ecuacion 8.7 de [1] con los resultados de la tabla anterior y las capacitancias calculadas en la `Parte 1`, se encontrar los siguientes valores para las resistencias efectivas de los transistores PMOS y NMOS de la tecnología XT018


|Transistor| Parámetro | Valor (kohm)|
|:---------:|:---------:|:----:|
|NMOS|  R_n  | 10.6 |
|PMOS|  R_p | 31.9  |



## 3. Referencias
[1] Weste and D. Harris, *CMOS VLSI Design: A Circuits and Systems Perspective*, 4th ed. Boston: Addison-Wesley, 2010.

[2] Process and Device Specification XH018 - 0.18 μm Modular Mixed Signal HV CMOS, PDS-018-13. Release 7.0.1. XFAB Semiconductor Foundries, Nov. 2017
