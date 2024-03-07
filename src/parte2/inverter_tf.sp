* inverter_tf.sp
****************************************************************
* Parameters and models
****************************************************************
.param SUPPLY=1.8
.temp 25
.param H=4
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
Vin a gnd 0
X1 a b inv                      * shape input waveform
**************************************************************
* Stimulus
**************************************************************
.dc Vin 0 1.8 0.01

.option post=1

.option runlvl = 5


.end
