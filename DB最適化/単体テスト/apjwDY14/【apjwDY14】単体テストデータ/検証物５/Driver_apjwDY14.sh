#! /bin/sh
#変数設定
export SJ_PEX_FRAME=apfxC000_xxxRX
export TS_RIYO_CMPCD=C000
export SJ_PEX_MAXRL=10
export SJ_PEX_DATE=20121120
export SJ_PEX_JOB=apjwDY14
export DD_MDYB1403_FLG=1
export DD_MDYB1401_FLG=0
export DD_MDYB1402_FLG=0
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
sh apjwDY14.sh go 
TS_STATUS=$?
echo "シェルapjwDY14のリターン値："${TS_STATUS}                 >> ${TS_LOGFILE}
