#! /bin/sh
#�ϐ��ݒ�
export SJ_PEX_FRAME=apfxC000_xxxRX
export TS_RIYO_CMPCD=C000
export BL_OPT_MAX=1
export SJ_PEX_DATE=20130331
export SJ_PEX_JOB=apjwDY14
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
sh apjwDY14.sh go 
TS_STATUS=$?
echo "�V�F��apjwDY14�̃��^�[���l�F"${TS_STATUS}                 >> ${TS_LOGFILE}
