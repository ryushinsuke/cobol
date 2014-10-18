#! /bin/sh
#-----------------------------------------------------------------------------------------
# �T�u�V�X�e���h�c  �F  GAMMA�c���f�[�^�����N��
# �T�u�V�X�e������  �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  BUSG1020
# ���W���[������    �F  GAMMA�c���f�[�^����
# �����T�v          �F  GAMMA�c���f�[�^����
# ����              �F  ARG1�Fgo
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    �S��     ���e
# --------  ----    ------  -------  -----------------------------
# 20080908  �V�K    SCS     �ڋ`�N �@�V�K�쐬
# 20090408  �C��    SCS     ���V��   �c�^�X�N�Ή��i194�j
# 20091215  �C��    SCS     �����Q   �A����Q�Ή��i2179�j
# 20130709  �C��    SCS     �N��     �e�[�}3545-1
# 20130808  �C��    SCS     �N��     �e�[�}3541
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
#BCZY0020���^�[���R�[�h
TS_BCZY0020_RCODE=0
TS_BCZY0020_CALL=0
#����FLG
TS_FILE_SONZAI=0
#FILE��TS_SIZE
TS_SIZE=0
#�V�F���̃��^�[���R�[�h
TS_RCODE=0
#�T�[�o�̃��^�[���R�[�h
TS_STATUS_20=0
TS_STATUS_240=0
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
#�V�F���G���[
CNS_SHELLERR=90

#�A��
CNS_NO_ID_1=01
CNS_NO_ID_2=02
CNS_NO_ID_3=03
CNS_NO_ID_4=04
CNS_NO_ID_5=05
CNS_NO_ID_6=06
CNS_NO_ID_7=07
CNS_NO_ID_8=08
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
echo "*** GAMMA�c���f�[�^�����N�� *** "                                                         >> $TS_LOGFILE


BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********���p��ЃR�[�h�A�������s���A�N��ID�A�Ɩ��^�X�NID�擾*******"                    >> $TS_LOGFILE
echo "���p��ЃR�[�h = ${TS_RIYOCMP_CD_SH}"                                                        >> $TS_LOGFILE
echo "�������s��     = ${TS_PEX_DATE_SH}"                                                          >> $TS_LOGFILE
echo "�N��ID         = ${TS_KIDO_ID_SH}"                                                           >> $TS_LOGFILE
echo "�Ɩ��^�X�NID   = ${TS_EXEC_ID_SH}"                                                           >> $TS_LOGFILE
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE


#-----------------------------------------------------------------------------------------
# �X�e�b�v-0020 ���s�󋵊Ǘ�UPD���C��
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************** ���s�󋵊Ǘ�UPD���C�� ************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
TS_STATUS_20=0
#�����P�F���p��ЃR�[�h�iSTEP1�擾�j
#�����Q�F�������s���iSTEP1�擾�j
#�����R�F�N��ID�iSTEP1�擾�j
#�����S�F�Z�b�V�����敪�i�P�F�擪�Z�b�V�����j
#�����T�F�A�b�v���[�h�������i0�j
#�����U�F�A�b�v���[�h�G���[�����i0�j
#�����V�FDL�t�@�C���o�͋敪�i�X�y�[�X)
echo "MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} \
               ${TS_SESSION_KBN_1} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"       >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_SESSION_KBN_1} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                  >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo  "�yMCZY7070�z(�Z�b�V�����敪=1) �߂�l��${TS_STATUS}"                                     >> $TS_LOGFILE
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
fi

BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
TS_STATUS_20=${TS_STATUS}

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0030 GAMMA�c���f�[�^����
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0030
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** GAMMA�c���f�[�^���� **************************"                >> $TS_LOGFILE

    TS_STEP_RCODE=0
    #�����P�F���p��ЃR�[�h�iSTEP1�擾�j
    #�����Q�F�������s���iSTEP1�擾�j
    #�����R�F�Ɩ��^�X�NID�iSTEP1�擾�j
    #�����S�F�N��ID�iSTEP1�擾�j

    echo "MUSR2651 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}"                   >> $TS_LOGFILE

    MUSR2651 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}                          >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    echo "MUSR2651 �߂�l��${TS_STATUS}"                                                        >> $TS_LOGFILE
    case $TS_STATUS in
    #����
    0)TS_STEP_RCODE=${CNS_NORMAL}
      echo "����I��"                                                                           >> $TS_LOGFILE
    ;;
    #�x��
    2)TS_STEP_RCODE=${CNS_WARNING}
      echo "�x���I��"                                                                           >> $TS_LOGFILE
    ;;
    #�Ɩ��G���[(���s��)
    4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
      echo "�Ɩ��G���[(���s��)�I��"                                                             >> $TS_LOGFILE
    ;;
    #�Ɩ��G���[�i���ב��s�s�j
    6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
      echo "�Ɩ��G���[�i���ב��s�s�j�I��"                                                     >> $TS_LOGFILE
    ;;
    #�Ɩ��G���[�i���������C�����s�s�j
    8)TS_STEP_RCODE=${CNS_GYOUMUERR_MAINSTOP}
      echo "�Ɩ��G���[�i���������C�����s�s�j�I��"                                             >> $TS_LOGFILE
    ;;
    #�Ɩ��G���[(���s�s��)
    10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
      echo "�Ɩ��G���[(���s�s��)�I��"                                                           >> $TS_LOGFILE
    ;;
    #�V�X�e���G���[
    16)TS_RCODE=1
       TS_STEP_RCODE=${CNS_SYSTEMERR}
       echo "�V�X�e���G���[�I��"                                                                >> $TS_LOGFILE
    ;;
    *)TS_RCODE=1
      TS_STEP_RCODE=${CNS_SYSTEMERR}
    ;;
    esac
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0031  ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0031
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#######    �A����Q493�̑Ή�  20080105 �C��  �J�n    ############
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0033 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0033
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#######    �A����Q493�̑Ή�  20080105 �C��  �I��    ############

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0040 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0040
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01
        if [ -d ${APL_FTP_DIR} ];then
              HERE=`pwd`
              cd ${APL_FTP_DIR}
             if [ -f ${TS_TAR_TSV} ];then
                echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                TS_STATUS=$?
                if [ "${TS_STATUS}" != "0" ];then
                    TS_STEP_RCODE=${CNS_SHELLERR}
                    TS_RCODE=1
                    echo "���k���s"                                                              >> $TS_LOGFILE
                else
                    echo "���k����"                                                              >> $TS_LOGFILE
                fi
             else
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
             fi
              cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0050 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0050
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_1}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0061 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0061
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK**************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#######    �A����Q493�̑Ή�  20080105 �C��  �J�n    ############
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0063 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0063
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#######    �A����Q493�̑Ή�  20080105 �C��  �I��    ############


#-----------------------------------------------------------------------------------------
# �X�e�b�v-0070 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0070
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0080 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0080
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_2}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0091 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0091
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0093 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0093
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0094 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0094
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0095 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0095
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_3}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0097 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0097
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0099 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0099
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0100 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0100
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0101 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0102
        BCZC1100.sh ${TS_STEPID}                                                                >> $TS_LOGFILE
        echo "*********************************************************************"            >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"            >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_4}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                               >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                      >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                      >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                      >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                               >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0110 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0110
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0111 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0111
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0112 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0112
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0113 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0113
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_5}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0120 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0120
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0121 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0121
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0122 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0122
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0123 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0123
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_6}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0130 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0130
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0131 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0131
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0132 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0132
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0133 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0133
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_7}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0140 ���FILE ���� CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0140
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** ���FILE ���� CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"���� "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"���݂��Ȃ�"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"��SIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"��SIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"��SIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# �X�e�b�v-0141 �t�@�C���o�̓t�H�[�}�b�g����
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0141
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* �t�@�C���o�̓t�H�[�}�b�g���� **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed�ԉ�l����
        TS_STATUS=$?
        echo "sed �߂�l��${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sed�G���["                                                                        >> $TS_LOGFILE
        else
            echo "sed����"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm�ԉ�l����
            TS_STATUS=$?
            echo "rm �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rm�G���["                                                                     >> $TS_LOGFILE
            else
                echo "rm����"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv�ԉ�l����
            TS_STATUS=$?
            echo "mv �߂�l��${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mv�G���["                                                                     >> $TS_LOGFILE
            else
                echo "mv����"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0142 �t�@�C�����k
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0142
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* �t�@�C�����k���� **************************"                >> $TS_LOGFILE

         TS_STEP_RCODE=0
         TS_TAR_TSV=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08
         if [ -d ${APL_FTP_DIR} ];then
               HERE=`pwd`
               cd ${APL_FTP_DIR}
              if [ -f ${TS_TAR_TSV} ];then
                 echo "gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV} "                                        >> $TS_LOGFILE

                 gzip -f ${APL_FTP_DIR}/${TS_TAR_TSV}                                                >> $TS_LOGFILE  2>&1
                 TS_STATUS=$?
                 if [ "${TS_STATUS}" != "0" ];then
                     TS_STEP_RCODE=${CNS_SHELLERR}
                     TS_RCODE=1
                     echo "���k���s"                                                              >> $TS_LOGFILE
                 else
                     echo "���k����"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "�t�@�C�����݂��܂���"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0143 END�t�@�C���쐬
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0143
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ END�t�@�C���쐬 ****************************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        TS_CTL=RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_${CNS_NO_ID_8}.ctl
        if [ -d ${APL_FTP_DIR} ];then
            HERE=`pwd`
            cd ${APL_FTP_DIR}
            echo "touch ${APL_FTP_DIR}/${TS_CTL}"                                                   >> $TS_LOGFILE

            touch ${APL_FTP_DIR}/${TS_CTL}                                                          >> $TS_LOGFILE  2>&1
            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ];then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "END�t�@�C���쐬���s"                                                          >> $TS_LOGFILE
            else
                echo "END�t�@�C���쐬����"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

##-----------------------------------------------------------------------------------------
## �X�e�b�v-0240 �O�ڃf�[�^�}�[�W���m����
##-----------------------------------------------------------------------------------------
TS_STEPID=0240
BCZC1100.sh ${TS_STEPID}     	                                                                >> $TS_LOGFILE
TS_STATUS_240=0
KAISYA_FILE="GX_COPY_LIST.dat"
#�����P�F���p��� (TS_RIYO_CMPCD)
#�����Q�F�������s�� (SJ_PEX_DATE)
#�����R�F�Ɩ��^�X�NID (TS_EXECID)
#�����S�F�N��ID (TS_KIDOID)

grep -q "${TS_RIYO_CMPCD}" ${APL_DATEFILE_DIR}/${KAISYA_FILE}                                   >> $TS_LOGFILE  2>&1
if [[ $? -eq 0 ]];then
    echo "��Ђ����݂���"                                                                       >> $TS_LOGFILE
  #echo "MDYJ2201 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_EXECID} ${TS_KIDOID}                     >> $TS_LOGFILE

  MDYJ2201 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_EXECID} ${TS_KIDOID}                            >> $TS_LOGFILE  2>&1

  TS_STATUS_240=$?
  echo "MDYJ2201 �߂�l��${TS_STATUS_240}"                                                      >> $TS_LOGFILE

  if [ "${TS_STATUS_240}" != "0" ];then
      TS_RCODE=1
      TS_STATUS_240=${CNS_SYSTEMERR}
  fi
else
  echo "��Ђ����݂��Ȃ�"                                                                       >> $TS_LOGFILE
fi

BCZC1199.sh ${TS_STEPID} ${TS_STATUS_240}                                                       >> $TS_LOGFILE

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0210 GX�T�[�oFTP����
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
	  TS_BCZY0020_CALL=1
    TS_STEP_RCODE=0
    TS_STEPID=0210
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "*********************** GX�T�[�oFTP���� *****************************"                >> $TS_LOGFILE

    echo "BCZY0020.sh go GXC"                                                                   >> $TS_LOGFILE
    BCZY0020.sh "go" "GXC"                                                                      >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    TS_BCZY0020_RCODE=${TS_STATUS}
    echo "BCZY0020 �߂�l��${TS_STATUS}"                                                        >> $TS_LOGFILE
    if [ "${TS_STATUS}" != "0" ];then
        TS_STEP_RCODE=${CNS_SYSTEMERR}
        TS_RCODE=1
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#-----------------------------------------------------------------------------------------
# �X�e�b�v-0220 GX�`�����ʍX�V�����N��
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0220
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "******************* GX�`�����ʍX�V�����N�� **************************"                >> $TS_LOGFILE

    TS_STEP_RCODE=0
    #�����P�F���p��ЃR�[�h�iSTEP1�擾�j
    #�����Q�F�������s���iSTEP1�擾�j
    #�����R�F�N��ID�iSTEP1�擾�j
    #�����S�F�Ɩ��^�X�NID�iSTEP1�擾�j
    #�����T�F�A�ԁi?�j�@�@�@�@�@�@�@�@
    echo "MCZY7330 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_EXEC_ID_SH} \
                   ${CNS_NO_ID_8} "                                                             >> $TS_LOGFILE

    MCZY7330 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_EXEC_ID_SH} \
             ${CNS_NO_ID_8}                                                                     >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    echo "MCZY7330 �߂�l��${TS_STATUS}"                                                        >> $TS_LOGFILE
    if [ "$TS_STATUS" != "0" ];then
        TS_RCODE=1
        TS_STEP_RCODE=${CNS_SYSTEMERR}
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    if [ "${TS_STATUS}" == "0" ];then
      if [ "${TS_STATUS_240}" == ${CNS_SYSTEMERR} ];then
        TS_RCODE=1
        sh BCZC9999.sh ${TS_RCODE}                                                              >> $TS_LOGFILE
        exit ${TS_RCODE}
      else
        sh BCZC9999.sh ${TS_RCODE}                                                              >> $TS_LOGFILE
        exit ${TS_RCODE}
      fi
    fi
fi
##-----------------------------------------------------------------------------------------
## �X�e�b�v-0230 ���s�󋵊Ǘ�UPD���C��
##-----------------------------------------------------------------------------------------
if [ ${TS_STATUS_20} == ${CNS_NORMAL} ];then
    TS_STEPID=0230
    BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
    echo "*********************************************************************"                    >> $TS_LOGFILE
    echo "********************���s�󋵊Ǘ�UPD���C��****************************"                    >> $TS_LOGFILE
    
    #�����P�F���p��ЃR�[�h�iSTEP1�擾�j
    #�����Q�F�������s���iSTEP1�擾�j
    #�����R�F�N��ID�iSTEP1�擾�j
    #�����S�F�Z�b�V�����敪�i2�F�I���Z�b�V�����j
    #�����T�F�A�b�v���[�h�������i0�j�@�@�@�@�@�@�@�@
    #�����U�F�A�b�v���[�h�G���[�����i0�j
    #�����V�FDL�t�@�C���o�͋敪     �@��BCZY0020���R�[�������̏ꍇ�A
    #�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@��BCZY0020��RTNCD��0�̏ꍇ�A
    #�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�EBCZY0020�̖߂�l���Z�b�g����                                �@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@
    #                             �@�@�@ ����L�ȊO�̏ꍇ�iBCZY0020��RTNCD��0�j�̏ꍇ�A�@
    #�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�E�����Z�b�g����@�@
    #�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@ ����L�ȊO�iBCZY0020���R�[������Ȃ��j�̏ꍇ�A
    #�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�E�����Z�b�g����@
    if [ ${TS_BCZY0020_CALL} = 1 ];then
       if [ ${TS_BCZY0020_RCODE} != 0 ];then
         TS_OUTFILE_KBN_B=${TS_BCZY0020_RCODE}
       else
         TS_OUTFILE_KBN_B=" "
       fi
    else
      TS_OUTFILE_KBN_B=" "
    fi
    TS_STEP_RCODE=0
    echo "MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} \
                   ${TS_SESSION_KBN_2} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"       >> $TS_LOGFILE
    
    MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_SESSION_KBN_2} \
             ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                  >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    echo "MCZY7070 �߂�l��${TS_STATUS}"                                                            >> $TS_LOGFILE
    if [ "$TS_STATUS" != "0" ];then
        TS_RCODE=1
        TS_STEP_RCODE=${CNS_SYSTEMERR}
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
fi

if [ ${TS_RCODE} != 0 ];then
    BCZC9999.sh ${TS_RCODE}                                                                     >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# �����I��
#-----------------------------------------------------------------------------------------
BCZC9999.sh ${TS_RCODE}                                                                         >> $TS_LOGFILE
exit 0
