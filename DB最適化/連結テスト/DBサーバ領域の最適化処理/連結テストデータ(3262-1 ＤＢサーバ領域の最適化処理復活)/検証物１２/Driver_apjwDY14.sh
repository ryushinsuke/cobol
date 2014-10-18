#! /bin/sh
#変数設定
export SJ_PEX_FRAME=apfxC000_xxxRX
export TS_RIYO_CMPCD=C000
export BL_OPT_MAX=1
export SJ_PEX_DATE=20130331
export SJ_PEX_JOB=apjwDY14
export APL_LOG_DIR=/home/apl/BL
export APL_TMP_DIR=/home/apl/BL/parm
export APL_DATEFILE_DIR=/home/apl/BL/mdat
export NAS_APL_DIR=/home/apl/BL
export ora_userid=ora007
export ora_password=ora007
export ora_ins_4999=ORCL_C
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
sh apjwDY14.sh go 
TS_STATUS=$?
echo "シェルapjwDY14のリターン値："${TS_STATUS}                 >> ${TS_LOGFILE}
