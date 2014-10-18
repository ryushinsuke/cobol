#! /bin/sh
#変数設定
export SJ_PEX_FRAME=apfxC000_xxxRX
export TS_RIYO_CMPCD=C000
export SJ_PEX_MAXRL=10240
export SJ_PEX_DATE=20121120
export SJ_PEX_JOB=MDYB1401
export ora_userid=ora007
export ora_password=ora007
export ora_ins_4999=ORCL_C
export APL_LOG_DIR=/home/apl/BL
export APL_DATEFILE_DIR=/home/apl/BL/mdat
export APL_TMP_DIR=/home/apl/BL/parm
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
#BCZC0001.sh                                       >> ${TS_LOGFILE}
#メインMDYB1401のコール
./MDYB1401 ${SJ_PEX_MAXRL} ${SJ_PEX_DATE}                                  >> ${TS_LOGFILE} 2>&1
TS_STATUS=$?
echo "MDYB1401のリターン値："${TS_STATUS}                 >> ${TS_LOGFILE}
