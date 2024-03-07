# Tarea 1 VLSI

###Parte 1
Para los calculos de corriente efectiva se utilzo la siguiente ecuacion:
[![Code-Cogs-Eqn.png](https://i.postimg.cc/HLTc0xKQ/Code-Cogs-Eqn.png)](https://postimg.cc/G4Smdcb2)  

Para la resistencia efectiva 
[![Code-Cogs-Eqn-1.png](https://i.postimg.cc/QC714zq5/Code-Cogs-Eqn-1.png)](https://postimg.cc/PvtCN29r)
Finalmente la resistencia total del canal es 

[![Code-Cogs-Eqn-2.png](https://i.postimg.cc/PJ1vzwtQ/Code-Cogs-Eqn-2.png)](https://postimg.cc/H8sLTj8r)

Segun los parametros suministrados por el profesor, estos son los resultados para NMOS y PMOS, respectivamente;

[![tabla.png](https://i.postimg.cc/G2hXfbBD/tabla.png)](https://postimg.cc/R3y165LC)
Para averiguar la constante RC, primero se calcula capacitancia efectiva con la ecuacion

[![ec.png](https://i.postimg.cc/fW7rRgsk/ec.png)](https://postimg.cc/V56R7gdc)

Segun la tabla proporcionada por el profesor; Cox es 8.46fF/um para NMOS y 8.91fF/um para el PMOS, y Cov es 0.33fF/um2 para NMOS y 0.32fF/um2 para PMOS. Ldib es 0.18 y Wdib es 0.22um, para ambos transistores (NMOS y PMOS). 

[![tabl.png](https://i.postimg.cc/pdGnCvKy/tabl.png)](https://postimg.cc/hJmj4Hyq)

###Parte 2
####2.a
[![curvas-nmos.png](https://i.postimg.cc/Sxj48pQg/curvas-nmos.png)](https://postimg.cc/TK8BMFDb)

Se desarrollo el estudio sobre la curva caracteristica del inversor en hspice, utilizando el archivo `src/parte2/inverter_tf.sp`. Primero, se utilizo el menor ancho permitido por la aplicacion, con un Wne=220nm para el NMOS y un Wpe=440nm para el PMOS. Se describio el ancho del PMOS, siempre como el doble del NMOS. El largo es de L=180nm, para ambos transistores. Este fue el resultado del mismo.

[![w220.png](https://i.postimg.cc/CxtRV6XX/w220.png)](https://postimg.cc/753H3Xxn)

Asimismo, se repiditio la simulacion para diferentes anchos para estudiar, como cambia la curva. Los cuales se mostraran a continuacion;
####Para Wne=440nm:

[![w440.png](https://i.postimg.cc/3rnJTcD1/w440.png)](https://postimg.cc/qg6dcQw6)

####Para Wne=660nm

[![w660.png](https://i.postimg.cc/tT9p03q8/w660.png)](https://postimg.cc/CZrWkff4)

####Wne=880nm

[![w880.png](https://i.postimg.cc/LXvRmJh5/w880.png)](https://postimg.cc/k6VLcXQP)

####Wne=1000nm

[![w880.png](https://i.postimg.cc/LXvRmJh5/w880.png)](https://postimg.cc/k6VLcXQP)




