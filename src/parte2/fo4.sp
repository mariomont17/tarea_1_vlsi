* fo4.sp
****************************************************************
* Parameters and models
****************************************************************
.param SUPPLY=1.8
.param H=4
.temp 25
*/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src
.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/xt018.lib' tm
.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/param.lib' 3s
.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Montero_Marenco_I_2024_vlsi/Tareas/tarea_1_vlsi/src/Hspice/lp5mos/config.lib' default
****************************************************************

.global vdd gnd

****************************************************************
* Subcircuits
****************************************************************
.subckt inv a y N=220n P=440n
xm0 y a gnd gnd ne w='N' l=180n as=-1 ad=-1 ps=-1 pd=-1
+ nrs=-1 nrd=-1 m='1*1' par1='1*1' xf_subext=0
xm1 y a vdd vdd pe w='P' l=180n as=-1 ad=-1 ps=-1
+ pd=-1 nrs=-1 nrd=-1 m='1*1' par1='1*1' xf_subext=0
.ends
***************************************************************
* Simulation Netlist
***************************************************************
v1 vdd gnd dc='SUPPLY'
v2 a gnd dc=0 pulse ( 0 'SUPPLY' 0p 100p 100p 2ns 4.2n )
X1 a b inv N=220n   P=440n     * shape input waveform
X2 b c inv N=880n   P=1760n    * reshape input waveform
X3 c d inv N=3520n  P=7040n    * device under test
X4 d e inv N=14080n P=28160n   * load
X5 e f inv N=56320n P=112640n  * load on load
**************************************************************
* Stimulus
**************************************************************
.tran 10p 3n start=0
.measure tpdr * rising prop delay
+ TRIG v(c) VAL='SUPPLY/2' FALL=1
+ TARG v(d) VAL='SUPPLY/2' RISE=1
.measure tpdf * falling prop delay
+ TRIG v(c) VAL='SUPPLY/2' RISE=1
+ TARG v(d) VAL='SUPPLY/2' FALL=1
.measure tpd param='(tpdr+tpdf)/2' * average prop delay
.measure trise * rise time
+ TRIG v(d) VAL='0.2*SUPPLY' RISE=1
+ TARG v(d) VAL='0.8*SUPPLY' RISE=1
.measure tfall * fall time
+ TRIG v(d) VAL='0.8*SUPPLY' FALL=1
+ TARG v(d) VAL='0.2*SUPPLY' FALL=1

*v7 net16 gnd dc=1.8
*v4 net15 gnd dc=0 pulse ( 0 1.8 0 100p 100p 2n 4.2n )

.option opfile=1 split_dp=1



.option post=1


.option runlvl = 5




.end
