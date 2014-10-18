#! /bin/sh
#-----------------------------------------------------------------------------------------
# �T�u�V�X�e���h�c  �F  �����ʕ]���v�Z�Ǘ�
# �T�u�V�X�e������  �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  BMHS0001
# ���W���[������    �F  �����ʕ]���v�Z�N��
# �����T�v          �F  �����ʕ]���v�Z�N��
# ����              �F  ARG1    :�@�@
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    ���e
# --------  ----    ------  --------------------------------------
# 20070917  �V�K    SCS     �ڎy�x �@�V�K�쐬
# 20091016  �C��    SCS     �ڎy�x   ������Q�Ή�No.0003149
# 20110414  �C��    SCS     �]����   �e�[�}3212-2
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# ���[�J���ϐ��ݒ�
#-----------------------------------------------------------------------------------------

#MCZY7070�̈���
#�Z�b�V�����敪�i�P�F�擪�Z�b�V�����j
TS_SESSION_KBN_1="1"
#�Z�b�V�����敪�i2�F�I���Z�b�V�����j
TS_SESSION_KBN_2="2"
#�A�b�v���[�h�������i0�j
TS_UPLOAD_CNT="0"
#�A�b�v���[�h�G���[�����i0�j
TS_UPLERR_CNT="0"
#DL�t�@�C���o�͋敪�i�X�y�[�X�j
TS_OUTFILE_KBN_B=" "

#�V�F���̃��^�[���R�[�h
TS_RCODE=0
#����
CNS_NORMAL=0
#######    ������Q�Ή�No.0003149 20091016 �C��  �J�n    #########
#�v���O�����E�H�[�j���O
CNS_WARNING=2
#######    ������Q�Ή�No.0003149 20091016 �C��  �I��    #########
#�Ɩ��G���[(���s��)
CNS_GYOUMUERR_GO=4
#�Ɩ��G���[(���ב��s�s��)
CNS_GYOUMUERR_MEISAISTOP=6
#�Ɩ��G���[(���������C�����s�s��)
CNS_GYOUMUERR_STOP=8
#######    ������Q�Ή�No.0003149 20091016 �C��  �J�n    #########
#�v���O�����Ɩ��G���[(���s�s�\)
CNS_GYOUMUERR_STOP2=10
#######    ������Q�Ή�No.0003149 20091016 �C��  �I��    #########
#�V�X�e���G���[
CNS_SYSTEMERR=16
#�V�F���G���[
CNS_SHELLERR=90

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0010 ���p��ЃR�[�h�A�������s���A�N��ID�A�Ɩ��^�X�NID �擾
#-----------------------------------------------------------------------------------------
TS_STEPID=0010

TS_STEP_RCODE=0

#���p��ЃR�[�h�@���@���ϐ�TS_RIYO_CMPCD
if [ "${TS_RIYO_CMPCD}" != "" ];then
    TS_RIYOCMP_CD=`echo ${TS_RIYO_CMPCD}`
else
    TS_RCODE=1
    echo "���p��ЃR�[�h�擾���s"
fi

#�������s���@���@���ϐ�SJ_PEX_DATE
if [ "${SJ_PEX_DATE}" != "" ];then
    TS_PEX_DATE=`echo ${SJ_PEX_DATE}`
else
    TS_RCODE=1
    echo "�������s���擾���s"
fi

#�N��ID�@���@���ϐ�TS_KIDOID
if [ "${TS_KIDOID}" != "" ];then
    TS_KIDO_ID=`echo ${TS_KIDOID}`
else
    TS_RCODE=1
    echo "�N��ID�擾���s"
fi

#�Ɩ��^�X�NID�@���@���ϐ�TS_EXECID
if [ "${TS_EXECID}" != "" ];then
    TS_EXEC_ID=`echo ${TS_EXECID}`
else
    TS_RCODE=1
    echo "�Ɩ��^�X�NID�擾���s"
fi

if [ ${TS_RCODE} != 0 ];then
    exit 1
fi

#TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}_${TS_KIDOID}.log
LogFile=${TS_LOGFILE};export LogFile


#sh BCZC0001.sh
sh BCZY0001.sh
sh BCZC0000.sh                                                                                  >> $TS_LOGFILE
echo "*** �����ʕ]���v�Z�N�� *** "                                                              >> $TS_LOGFILE

sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********���p��ЃR�[�h�A�������s���A�N��ID�A�Ɩ��^�X�NID�擾*******"                    >> $TS_LOGFILE
echo "���p��ЃR�[�h = ${TS_RIYOCMP_CD}"                                                        >> $TS_LOGFILE
echo "�������s��     = ${TS_PEX_DATE}"                                                          >> $TS_LOGFILE
echo "�N��ID         = ${TS_KIDO_ID}"                                                           >> $TS_LOGFILE
echo "�Ɩ��^�X�NID     = ${TS_EXEC_ID}"                                                           >> $TS_LOGFILE
sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0020 ���s�󋵊Ǘ�UPD���C��
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********���s�󋵊Ǘ�UPD���C��**************************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Z�b�V�����敪�i�P�F�擪�Z�b�V�����j
#�����T�F�A�b�v���[�h�������i0�j
#�����U�F�A�b�v���[�h�G���[�����i0�j
#�����V�FDL�t�@�C���o�͋敪�i�X�y�[�X)
echo "MCZY7070 ${TS_RIYOCMP_CD}    ${TS_PEX_DATE}   ${TS_KIDO_ID} \
               ${TS_SESSION_KBN_1} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"      >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} ${TS_SESSION_KBN_1} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                 >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
    if [ "${TS_DNKBN}" = "N" ];then
        sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
    fi
fi

sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    sh BCZC9999.sh ${TS_RCODE}                                                                  >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0030 �����ʕ]���v�Z�N��
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "*************************�����ʕ]���v�Z�N��**************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Ɩ��^�X�NID�iSTEP1�擾�j

echo "MMHJ0010 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}"                       >> $TS_LOGFILE

MMHJ0010 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}                              >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo "MMHJ0010 �߂�l��${TS_STATUS}"                                                            >> $TS_LOGFILE
case $TS_STATUS in
#����
0)TS_STEP_RCODE=${CNS_NORMAL}
  echo "����I��"                                                                               >> $TS_LOGFILE
;;
#######    ������Q�Ή�No.0003149 20091016 �C��  �J�n    #########
#�v���O�����E�H�[�j���O
2)TS_STEP_RCODE=${CNS_WARNING}
  echo "�v���O�����E�H�[�j���O"                                                                 >> $TS_LOGFILE
;;
#######    ������Q�Ή�No.0003149 20091016 �C��  �I��    #########
#�Ɩ��G���[(���s��)
4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
  echo "�Ɩ��G���[(���s��)�I��"                                                                 >> $TS_LOGFILE
;;
#�Ɩ��G���[(���s��)
6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
  echo "�Ɩ��G���[(���ב��s�s��)�I��"                                                           >> $TS_LOGFILE
;;
#######    ������Q�Ή�No.0003149 20091016 �C��  �J�n    #########
#�Ɩ��G���[(���������C�����s�s��)
8)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
  echo "�Ɩ��G���[(���������C�����s�s��)�I��"                                                   >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
#�Ɩ��G���[(���s�s��)
10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP2}
  echo "�Ɩ��G���[(���s�s��)�I��"                                                               >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
#######    ������Q�Ή�No.0003149 20091016 �C��  �I��    #########
#�V�X�e���G���[
16)TS_RCODE=1
   TS_STEP_RCODE=${CNS_SYSTEMERR}
   echo "�V�X�e���G���[�I��"                                                                    >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
*)TS_RCODE=1
  TS_STEP_RCODE=${CNS_SYSTEMERR}
# if [ "${TS_DNKBN}" = "N" ];then
#     sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]       >> $TS_LOGFILE  2>&1
# fi
;;
esac
sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE

##-----------------------------------------------------------------------------------------
## �X�e�b�v-0040 ���s�󋵊Ǘ�UPD���C��
##-----------------------------------------------------------------------------------------
TS_STEPID=0040
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********���s�󋵊Ǘ�UPD���C��**************************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Z�b�V�����敪�i2�F�I���Z�b�V�����j
#�����T�F�A�b�v���[�h�������i0�j�@�@�@�@�@�@�@�@
#�����U�F�A�b�v���[�h�G���[�����i0�j
#�����V�FDL�t�@�C���o�͋敪�i�X�y�[�X)
echo "MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} \
               ${TS_SESSION_KBN_2} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"                 >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} ${TS_SESSION_KBN_2} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                        >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
    if [ "${TS_DNKBN}" = "N" ];then
        sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -m�W���u���ُ�I�����܂���[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
    fi
fi

sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    sh BCZC9999.sh ${TS_RCODE}                                                                  >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# �����I��
#-----------------------------------------------------------------------------------------
sh BCZC9999.sh ${TS_RCODE}                                                                      >> $TS_LOGFILE
exit 0
