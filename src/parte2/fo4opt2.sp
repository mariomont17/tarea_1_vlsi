* fo4opt.sp
****************************************************************
* Parameters and models
****************************************************************
.param SUPPLY=1.8
.temp 25
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
v2 a gnd dc=0 pulse ( 0 'SUPPLY' 0p 100p 100p 1n 2n )
X1 a b inv P='P1*220e-9'              * shape input waveform
X2 b c inv P='P1*220e-9' M=4          * reshape input waveform
X3 c d inv P='P1*220e-9' M=16         * device under test
X4 d e inv P='P1*220e-9' M=64         * load
X5 e f inv P='P1*220e-9' M=256        * load on load
**************************************************************
* Optimization SetUp
**************************************************************
.param P1=optrange(2,1,4)      * search from 1 to 4, guess 2
.model optmod opt itropt=30     * maximum of 30 iterations
.measure bestratio param='P1'   * compute best P/N ratio
**************************************************************
* Stimulus
**************************************************************
.tran 0.01p 2n SWEEP OPTIMIZE=optrange RESULTS=diff MODEL=optmod
*.tran 0.01p 2n SWEEP OPTIMIZE=optrange RESULTS=tpd MODEL=optmod 

.measure tpdr                              * rising propagation delay
+ TRIG v(c) VAL='SUPPLY/2' FALL=1
+ TARG v(d) VAL='SUPPLY/2' RISE=1
.measure tpdf                              * falling propagation delay
+ TRIG v(c) VAL='SUPPLY/2' RISE=1
+ TARG v(d) VAL='SUPPLY/2' FALL=1
.measure tpd param='(tpdr+tpdf)/2' goal=0       * average prop delay
.measure diff param='abs(tpdr-tpdf)' goal=0   * diff between delays

.print P(v1)
.measure pwr AVG P(v1) FROM=0ps TO=2ns

.option opfile=1 split_dp=1


.option post=1


.option runlvl = 5




.end
