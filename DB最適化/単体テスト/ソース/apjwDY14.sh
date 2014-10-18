#! /bin/sh
#-----------------------------------------------------------------------------------------
# �V�X�e���h�c      �F  TSTAR
# �V�X�e������      �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  apjwDY14
# ���W���[������    �F  DB�T�[�o�̈�̍œK������
# �����T�v          �F  DB�T�[�o�̈�̍œK������
# ����              �F  ARG1: go
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    ���e
# --------  ----    ------  --------------------------------------
# 20090306  �V�K    SCS
# 20090605  �X�V    SCS     INMPORT������ADUMP�t�@�C�����폜����
# 20091029  �X�V    SCS     INMPORT�̃I�v�V������BUFFER=80000��ǉ�����
# 20130226  �X�V    GUT     �e�[�}3262-1:�c�a�T�[�o�̈�̍œK����������
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# ���[�J���ϐ��ݒ�
#-----------------------------------------------------------------------------------------
#���p��ЃR�[�h
TS_RIYO_CMPCD=`echo ${SJ_PEX_FRAME}|awk '{print substr($1,5,4)}'`
#�o�b�`���O�t�@�C��
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log

#�V�F���̃��^�[���R�[�h
TS_RCODE=0

#-----------------------------------------------------------------------------------------
#DB�T�[�o�̈�̍œK������ START
#-----------------------------------------------------------------------------------------
BCZC0001.sh
BCZC0000.sh                                       >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
# �����m�F
#-----------------------------------------------------------------------------------------
if [ "$1" != "go" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
   TS_RCODE=1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0010 �œK����~�t�@�C���̑��݃`�F�b�N
#-----------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#�œK����~�t�@�C��
TS_STOPFILE=${NAS_APL_DIR}/C000/stop/OPTTABLE_STOP_FILE.TXT

if [ -f ${TS_STOPFILE} ]; then
    echo "�œK����~�t�@�C���̐ݒu�ɂ�菈�����X�L�b�v���܂���"         >> ${TS_LOGFILE}
    TS_STEP_RCODE=0
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}     >> ${TS_LOGFILE}
    TS_RCODE=0
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

TS_STEP_RCODE=0
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0020 �œK���Ǘ����׃e�[�u���X�V����
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#���
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1403�œK���Ǘ����׃e�[�u���X�V����
MDYB1403 ${TS_KJN_YMD}                            >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDB�T�[�o�̈�̍œK������[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#�X�e�b�v-0030 MDYB1401�œK���Ώۃt�@�C���쐬����
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#�œK��MAX�e��
let TS_MAX_YOURYOU=${BL_OPT_MAX}*1024
#���
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1401�œK���Ώۃt�@�C���쐬����
MDYB1401  ${TS_MAX_YOURYOU} ${TS_KJN_YMD}        >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}        >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDB�T�[�o�̈�̍œK������[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                      >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#�X�e�b�v-0040 DB�T�[�o�̈�̍œK������
#-----------------------------------------------------------------------------------------
TS_STEPID=0040
BCZC1100.sh ${TS_STEPID}                         >> ${TS_LOGFILE}

TS_TBL_FILE=${APL_TMP_DIR}/OPTTABLE_${TS_KJN_YMD}.lst
TS_ORACLE=${ora_userid}/${ora_password}@${ora_ins_4999}
TS_TBL_COUNT=0
while read TS_LINE
do
      if [ "${TS_LINE}" = "" ];then
          break
      else
          TS_TBL_ID=`echo ${TS_LINE}|awk -F, '{print $1}'`
          TS_PAR_NAME=`echo ${TS_LINE}|awk -F, '{print $2}'`
#         TS_DMP_FILE=${BL_TMP_PATH}/${TS_TBL_ID}.dmp
          let TS_TBL_COUNT=${TS_TBL_COUNT}+1
      fi
      
#�œK����~�t�@�C���̑��݃`�F�b�N
      if [ -f ${TS_STOPFILE} ]; then
        echo "�œK����~�t�@�C���̐ݒu�ɂ�菈���𒆒f���܂���"         >> ${TS_LOGFILE}
        sed -i "${TS_TBL_COUNT},\$d" ${TS_TBL_FILE}                     >> ${TS_LOGFILE}
        TS_STATUS=0
        break
      fi
      
#�œK���Ώۃt�@�C���Ƀe�[�u���̍œK���J�n�������X�V����B
      sed -i "${TS_TBL_COUNT}s/00000000000000/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}

#�e�[�u��ID �p�[�e�B�V������ MOVE �J�n ���t����
      echo ${TS_TBL_ID} ${TS_PAR_NAME} MOVE �J�n `date '+%Y%m%d%H%M%S'`                    >> ${TS_LOGFILE}

#�e�[�u����MOVE
      if [ -z ${TS_PAR_NAME} ];then
        TS_MVSQL="ALTER TABLE ${TS_TBL_ID} MOVE;"
      else
        TS_MVSQL="ALTER TABLE ${TS_TBL_ID} MOVE PARTITION ${TS_PAR_NAME};"
      fi
      sqlplus -s ${TS_ORACLE} <<SQLEND                                  >> ${TS_LOGFILE}
      ${TS_MVSQL}
      EXIT;
SQLEND

#�e�[�u��ID �p�[�e�B�V������ MOVE �I�� ���t����
      echo ${TS_TBL_ID} ${TS_PAR_NAME} MOVE �I�� `date '+%Y%m%d%H%M%S'`                    >> ${TS_LOGFILE}

#�œK���Ώۃt�@�C���Ƀe�[�u���̍œK���I���������X�V����B
      sed -i "${TS_TBL_COUNT}s/99999999999999/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}

#�e�[�u��ID EXPORT �J�n ���t����
#     echo ${TS_TBL_ID} EXPORT �J�n `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#�e�[�u����EXPORT
#      exp ${TS_ORACLE} FILE=${TS_DMP_FILE} TABLES=${TS_TBL_ID}   >> ${TS_LOGFILE} 2>&1
#
#
#EXPORT�G���[����
#     grep 'EXP-' ${TS_LOGFILE}
#     TS_STATUS=$?
#     if [ "$TS_STATUS" = "0" ];then
#         TS_STATUS=16
#         break
#     else
#         TS_STATUS=0
#     fi
#
#�e�[�u��ID EXPORT �I�� ���t����
#     echo ${TS_TBL_ID} EXPORT �I�� `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#�e�[�u��ID TRUNCATE �J�n ���t����
#     echo ${TS_TBL_ID} TRUNCATE �J�n `date '+%Y%m%d%H%M%S'`    >> ${TS_LOGFILE}
#
#TRUNCATE table �e�[�u��ID
#sqlplus -s ${TS_ORACLE} <<SQLEND                            >> ${TS_LOGFILE}
#TRUNCATE TABLE ${TS_TBL_ID};
#EXIT;
#SQLEND
#
#�e�[�u��ID TRUNCATE �I�� ���t����
#     echo ${TS_TBL_ID} TRUNCATE �I�� `date '+%Y%m%d%H%M%S'`    >> ${TS_LOGFILE}
#
#�e�[�u��ID IMPORT �J�n ���t����
#     echo ${TS_TBL_ID} IMPORT �J�n `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#�e�[�u����IMPORT
#     imp ${TS_ORACLE} ignore=y FILE=${TS_DMP_FILE} TABLES=${TS_TBL_ID} BUFFER=80000       >> ${TS_LOGFILE} 2>&1
#
#IMPORT�G���[����
#     grep 'IMP-' ${TS_LOGFILE}
#     TS_STATUS=$?
#     if [ "$TS_STATUS" = "0" ];then
#         TS_STATUS=16
#         break
#     else
#         TS_STATUS=0
#     fi
#
#�e�[�u��ID IMPORT �I�� ���t����
#     echo ${TS_TBL_ID} IMPORT �I�� `date '+%Y%m%d%H%M%S'`   >> ${TS_LOGFILE}
#
#�œK���Ώۃt�@�C���Ƀe�[�u���̍œK���J�n�������X�V����B
#      sed -i "${TS_TBL_COUNT}s/99999999999999/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}
#
#DUMP�t�@�C�����폜����B
#      rm ${TS_DMP_FILE}                                     >> ${TS_LOGFILE} 2>&1
#      TS_STATUS=$?
#      if [ ${TS_STATUS} != "0" ];then
#          TS_STATUS=16
#          break
#      fi

done<${TS_TBL_FILE}

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDB�T�[�o�̈�̍œK������[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#�X�e�b�v-0050 MDYB1402�œK�����ʍX�V����
#-----------------------------------------------------------------------------------------
TS_STEPID=0050
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#���
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1402�œK�����ʍX�V����
MDYB1402   ${TS_KJN_YMD}                          >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDB�T�[�o�̈�̍œK������[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#DB�T�[�o�̈�̍œK������ END
#-----------------------------------------------------------------------------------------
TS_RCODE=0
BCZC9999.sh ${TS_RCODE}                           >> ${TS_LOGFILE}
exit ${TS_RCODE}
