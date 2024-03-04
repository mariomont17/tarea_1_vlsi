* fo3.sp
* RATIO = 2/1
****************************************************************
* Parameters and models
****************************************************************
.param SUPPLY=1.8
.temp 25
.param H=3
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
v2 a gnd dc=0 pulse ( 0 'SUPPLY' 0p 20p 20p 400p 800p )
*X1 a b inv N=220n   P=440n     * shape input waveform
*X2 b c inv N=880n   P=1760n    * reshape input waveform
*X3 c d inv N=3520n  P=7040n    * device under test
*X4 d e inv N=14080n P=28160n   * load
*X5 e f inv N=56320n P=112640n  * load on load
X1 a b inv                      * shape input waveform
X2 b c inv M='H'                * reshape input waveform
X3 c d inv M='H**2'             * device under test
X4 d e inv M='H**3'             * load
X5 e f inv M='H**4'             * load on load
**************************************************************
* Stimulus
**************************************************************
.tran 0.01p 800p start=0
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

.measure diff param='tpdr-tpdf' * diff between delays

.option opfile=1 split_dp=1



.option post=1


.option runlvl = 5




.end
