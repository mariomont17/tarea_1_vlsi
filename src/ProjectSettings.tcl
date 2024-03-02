#----------------------------------------------------------------------------
# do not modify this file
#----------------------------------------------------------------------------
proc ProjectSettings {} {
     global Project

     set Project [list \
                 [list KitFlowVersion v3_3_0] \
                 [list Timestamp 1709341503] \
                 [list Technology xt018] \
                 [list libCode 1243] \
                 [list Version v12_1_1_1] \
                 [list Type new] \
                 [list AnalogLibs {}] \
                 [list AntennaICVVersion {v3_0 v3_0_1}] \
                 [list AntennaPaths ./AntennaIcv] \
                 [list CalibreRunsetCode 1243] \
                 [list CalibreVersion {NULL NULL}] \
                 [list Core {LP 1.8V}] \
                 [list DRCICVIncludePaths ./ICValidator] \
                 [list DRCTool {IC Validator}] \
                 [list DigitalLibs {{D_CELLS_HDLL {v1_3 v1_3_0}} {D_CELLS_HDMV {v2_1 v2_1_1}} {GATES_HD {v1_1 v1_1_1}} {GATES_HD5V {v1_1 v1_1_1}} {GATES_SVT {v1_0 v1_0_0}} {IO_CELLS_FC1V8 {v1_2 v1_2_5}} {IO_CELLS_FC5V {v3_0 v3_0_0}}}] \
                 [list DrcRunsetFile ./ICValidator/xt018_1243_DRC_LP5MOS_MET4_METMID_METTHK.rs] \
                 [list EsdLibs {}] \
                 [list FTKCkitDir /mnt/vol_synopsys2023/pdks/xfab/design/xkit] \
                 [list GatesPcell {}] \
                 [list HspiceLib {{./Hspice/lp5mos/xt018.lib tm} {./Hspice/lp5mos/param.lib 3s} {./Hspice/lp5mos/config.lib default}}] \
                 [list HspiceModule lp5mos] \
                 [list HspiceVersion {v12_1 v12_1_3}] \
                 [list ICVVersion {v12_1 v12_1_1}] \
                 [list LVSICVIncludePaths {./ICValidator ./StarRC}] \
                 [list LVSSchNetlistFormat CDL] \
                 [list LVSTool {IC Validator}] \
                 [list LvsRunsetFile ./StarRC/xt018_1243_StarRCXT_LP5MOS_MET4_METMID_METTHK.rs] \
                 [list Metal Thin4] \
                 [list PEXCalibreRunsetCode 1243] \
                 [list PEXCalibreVersion {NULL NULL}] \
                 [list PRIMLIB PRIMLIB] \
                 [list Primlib PRIMLIB_1243] \
                 [list RunsetCode LP5MOS_MET4_METMID_METTHK] \
                 [list StarOADeviceMappingFile ./StarRC/OA_DEVICE_MAP] \
                 [list StarRCCmdFile ./StarRC/star_cmd] \
                 [list StarRCNxtGrd ./StarRC/xt018_xx43_MET4_METMID_METTHK_typ.nxtgrd] \
                 [list StarRCRunsetFile ./StarRC/xt018_1243_StarRCXT_LP5MOS_MET4_METMID_METTHK.rs] \
                 [list StarRCVersion {v12_1 v12_1_1}] \
                 [list StreamLayerMapFile ./strmInOut.layertable] \
                 [list StreamObjectMapFile ./strmOutObjects.map] \
                 [list TechFile TECH_XT018_1243] \
                 [list TopMetal METTP&METTPL] \
                 [list XticFlow new] \
                 [list edaTool CustomCompiler] \
                 [list warn {no Info}] \
        ]
}
