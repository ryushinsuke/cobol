#! /bin/sh
#-----------------------------------------------------------------------------------------
# �T�u�V�X�e���h�c  �F  �^�p���ʎc���f�[�^�ۑ�
# �T�u�V�X�e������  �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  BUSS1020
# ���W���[������    �F  �^�p���ʎc���f�[�^�ۑ�
# �����T�v          �F  �^�p���ʎc���f�[�^�ۑ�
# ����              �F  ARG1    :�@�@
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    ���e
# --------  ----    ------  --------------------------------------
# 20080903  �V�K    SCS     ������ �@�V�K�쐬
# 20090409  �C��    SCS     ���V��   �c�^�X�N194�Ή�
# 20130709  �C��    SCS     �N��     �e�[�}3545-1
#
# Copyright (C) 2008 by Nomura Research Institute,Ltd.
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
TS_OUTFILE_KBN_SPACE=" "
TS_OUTFILE_KBN_9="9"
#�V�F���̃��^�[���R�[�h
TS_RCODE=0
#����
CNS_NORMAL=0
#�x��
CNS_WARNING=2
#�Ɩ��G���[�i���s�\�j
CNS_GYOUMUERR_GO=4
#�Ɩ��G���[�i���ב��s�s�j
CNS_GYOUMUERR_MEISAISTOP=6
#�Ɩ��G���[�i���������C�����s�s�j
CNS_GYOUMUERR_MAINSTOP=8
#�Ɩ��G���[�i���s�s�j
CNS_GYOUMUERR_STOP=10
#�V�X�e���G���[
CNS_SYSTEMERR=16


#-------------------------------------------------------------------------------
# �����m�F
#-------------------------------------------------------------------------------
if [ "$1" != "go" ];then
    echo "Argument Error"
    TS_RCODE=1
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
# sleep
#-----------------------------------------------------------------------------------------
sleep 5

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0010 ���p��ЃR�[�h�A�������s���A�N��ID�A�Ɩ��^�X�NID �擾
#-----------------------------------------------------------------------------------------
TS_STEPID=0010

TS_STEP_RCODE=0

#���p��ЃR�[�h�@���@���ϐ�TS_RIYO_CMPCD
if [ "${TS_RIYO_CMPCD}" != "" ];then
    TS_RIYOCMP_CD_SH=`echo ${TS_RIYO_CMPCD}`
else
    TS_RCODE=1
    echo "���p��ЃR�[�h�擾���s"
fi

#�������s���@���@���ϐ�SJ_PEX_DATE
if [ "${SJ_PEX_DATE}" != "" ];then
    TS_PEX_DATE_SH=`echo ${SJ_PEX_DATE}`
else
    TS_RCODE=1
    echo "�������s���擾���s"
fi

#�N��ID�@���@���ϐ�TS_KIDOID
if [ "${TS_KIDOID}" != "" ];then
    TS_KIDO_ID_SH=`echo ${TS_KIDOID}`
else
    TS_RCODE=1
    echo "�N��ID�擾���s"
fi

#�Ɩ��^�X�NID�@���@���ϐ�TS_EXECID
if [ "${TS_EXECID}" != "" ];then
    TS_EXEC_ID_SH=`echo ${TS_EXECID}`
else
    TS_RCODE=1
    echo "�Ɩ��^�X�NID�擾���s"
fi

if [ ${TS_RCODE} != 0 ];then
    exit 1
fi

#TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYOCMP_CD_SH}/${SJ_PEX_JOB}.log
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYOCMP_CD_SH}/${SJ_PEX_JOB}_${TS_KIDOID}.log
LogFile=${TS_LOGFILE};export LogFile

#BCZC0001.sh
BCZY0001.sh
BCZC0000.sh                                                                                     >> $TS_LOGFILE
echo "*** �^�p���ʎc���f�[�^�ۑ��N�� *** "                                                      >> $TS_LOGFILE


BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********���p��ЃR�[�h�A�������s���A�N��ID�A�Ɩ��^�X�NID�擾*******"                    >> $TS_LOGFILE
echo "���p��ЃR�[�h = ${TS_RIYOCMP_CD_SH}"                                                        >> $TS_LOGFILE
echo "�������s��     = ${TS_PEX_DATE_SH}"                                                          >> $TS_LOGFILE
echo "�N��ID         = ${TS_KIDO_ID_SH}"                                                           >> $TS_LOGFILE
echo "�Ɩ��^�X�NID     = ${TS_EXEC_ID_SH}"                                                         >> $TS_LOGFILE
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE


#-----------------------------------------------------------------------------------------
# �X�e�b�v-0020 ���s�󋵊Ǘ�UPD���C��
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************���s�󋵊Ǘ�UPD���C��****************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Z�b�V�����敪�i�P�F�擪�Z�b�V�����j
#�����T�F�A�b�v���[�h�������i0�j
#�����U�F�A�b�v���[�h�G���[�����i0�j
#�����V�FDL�t�@�C���o�͋敪�i�X�y�[�X)
echo "MCZY7070 ${TS_RIYOCMP_CD_SH}    ${TS_PEX_DATE_SH}   ${TS_KIDO_ID_SH} \
               ${TS_SESSION_KBN_1} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"       >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_SESSION_KBN_1} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                  >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
fi

BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    BCZC9999.sh ${TS_RCODE}                                                                     >> $TS_LOGFILE
    exit 1
fi

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_STOP} ];then
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0030 �^�p���ʎc���f�[�^�ۑ�
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************�^�p���ʎc���f�[�^�ۑ�***********************"                        >> $TS_LOGFILE

TS_STEP_RCODE=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�Ɩ��^�X�NID�iSTEP1�擾�j
#�����S�F�N��ID�iSTEP1�擾�j

echo "MUSJ0251 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}"                       >> $TS_LOGFILE

MUSJ0251 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}                              >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo "MUSJ0251 �߂�l��${TS_STATUS}"                                                            >> $TS_LOGFILE
case $TS_STATUS in
#����
0)TS_STEP_RCODE=${CNS_NORMAL}
  echo "����I��"                                                                               >> $TS_LOGFILE
;;
#�x��
2)TS_STEP_RCODE=${CNS_WARNING}
  echo "�x���I��"                                                                               >> $TS_LOGFILE
;;
#�Ɩ��G���[(���s��)
4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
  echo "�Ɩ��G���[(���s��)�I��"                                                                 >> $TS_LOGFILE
;;
#�Ɩ��G���[�i���ב��s�s�j
6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
  echo "�Ɩ��G���[�i���ב��s�s�j�I��"                                                         >> $TS_LOGFILE
;;
#�Ɩ��G���[�i���������C�����s�s�j
8)TS_STEP_RCODE=${CNS_GYOUMUERR_MAINSTOP}
  echo "�Ɩ��G���[�i���������C�����s�s�j�I��"                                                 >> $TS_LOGFILE
;;
#�Ɩ��G���[(���s�s��)
10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
  echo "�Ɩ��G���[(���s�s��)�I��"                                                               >> $TS_LOGFILE
;;
#�V�X�e���G���[
16)TS_RCODE=1
   TS_STEP_RCODE=${CNS_SYSTEMERR}
   echo "�V�X�e���G���[�I��"                                                                    >> $TS_LOGFILE
;;
*)TS_RCODE=1
  TS_STEP_RCODE=${CNS_SYSTEMERR}
;;
esac
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
fi

##-----------------------------------------------------------------------------------------
## �X�e�b�v-0040 ���s�󋵊Ǘ�UPD���C��
##-----------------------------------------------------------------------------------------
TS_STEPID=0040
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************���s�󋵊Ǘ�UPD���C��****************************"                    >> $TS_LOGFILE

#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Z�b�V�����敪�i2�F�I���Z�b�V�����j
#�����T�F�A�b�v���[�h�������i0�j�@�@�@�@�@�@�@�@
#�����U�F�A�b�v���[�h�G���[�����i0�j
#�����V�FDL�t�@�C���o�͋敪     RTNCD��16�̏ꍇ�Ɂ��A
#                               RTNCD=16�̏ꍇ��9�A
if [ ${TS_STEP_RCODE} != ${CNS_SYSTEMERR} ];then
    TS_OUTFILE_KBN_B=${TS_OUTFILE_KBN_SPACE}
fi
if [ ${TS_STEP_RCODE} -eq ${CNS_SYSTEMERR} ];then
    TS_OUTFILE_KBN_B=${TS_OUTFILE_KBN_9}
fi
TS_STEP_RCODE=0
echo "MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} \
               ${TS_SESSION_KBN_2} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"       >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_SESSION_KBN_2} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                  >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
fi

BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    BCZC9999.sh ${TS_RCODE}                                                                     >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# �����I��
#-----------------------------------------------------------------------------------------
BCZC9999.sh ${TS_RCODE}                                                                         >> $TS_LOGFILE
exit 0
