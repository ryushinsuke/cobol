#! /bin/sh
#変数設定
export SJ_PEX_FRAME=apfxC000_xxxRX
export TS_RIYO_CMPCD=C000
export SJ_PEX_DATE=20121120
export SJ_PEX_JOB=MDYB1403
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
BCZC0001.sh                                       >> ${TS_LOGFILE}
#メインMDYB1403のコール
MDYB1403 ${SJ_PEX_DATE}                                  >> ${TS_LOGFILE} 2>&1
TS_STATUS=$?
echo "MDYB1403のリターン値："${TS_STATUS}                 >> ${TS_LOGFILE}
