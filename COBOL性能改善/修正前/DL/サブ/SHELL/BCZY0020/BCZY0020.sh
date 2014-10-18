#! /bin/sh
#-----------------------------------------------------------------------------------------
# �V�X�e���h�c      �F  TSTAR
# �V�X�e������      �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  BCZY0020
# ���W���[������    �F  GX�T�[�oFTP����
# �����T�v          �F  GX�T�[�oFTP����
# ����              �F  ARG1: go
#                       ARG2: �t�@�C�����
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    ���e
# --------  ----    ------  --------------------------------------
# 20080820  �V�K    SCS
# 20100415  �C��    SCS     ��@�� �@�d�l�ύX302�A�V�F���̍Ō�Ń��l�[������B
# 20100805  �C��    SCS     ��@�� �@�e�[�}2818�Ή�
# 20120703  �C��    SCS     ���u�R �@
# 20121218  �C��    ISC     �ӏ��g �@�e�[�}3421�Ή�
# 20130709  �C��    SCS     �V����   �e�[�}3545-1
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------
#GX�T�[�oFTP����    START
#-----------------------------------------------------------------------------------------
#���[�J���ϐ��ݒ�
#-----------------------------------------------------------------------------------------
#���C�����O�t�@�C��
#TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}_${TS_KIDOID}.log

#�V�F���̃��^�[���R�[�h
TS_RCODE=0

#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
BCZC0000.sh                                       >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
#�����m�F
#-----------------------------------------------------------------------------------------
if [ "$1" != "go" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
    TS_RCODE=9
    echo "���^�[���R�[�h="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
if [ "$2" = "" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
    TS_RCODE=9
    echo "���^�[���R�[�h="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
#-----------------------------------------------------------------------------------------
#�X�e�b�v-0010 MCZY7170���MID�擾���C��
#-----------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#MCZY7170���MID�擾���C��
MCZY7170 ${TS_RIYO_CMPCD} $2 ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}       >> ${TS_LOGFILE} 2>&1
TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=9
    echo "���^�[���R�[�h="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#�X�e�b�v-0020 ����t�@�C���̓��e���擾����
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#���
TS_KJN_YMD=${SJ_PEX_DATE}
#����t�@�C���̃p�X
TS_CTRL_FILE_PATH=${APL_TMP_DIR}
#����t�@�C����
TS_CTRL_FILE_NAME_1=${TS_RIYO_CMPCD}_${SJ_PEX_DATE}_${TS_KIDOID}_SCZY7180
#�A��
TS_NO=1
#�����t���O�t�@�C���̃p�X
TS_FLG_FILE_PATH=${NAS_APL_DIR}/C000/ftp
#bkup�t�H���_
TS_BKUP_PATH=${NAS_APL_DIR}/C000/ftp/bkup
#�f�t�H�[���g�z�M�T�[�o��
TS_DEF_SERVE_NAME=`eval echo '$'GX_FT_$TS_RIYO_CMPCD`

while [ "${TS_NO}" -le 99 ]
do
  if [ "${TS_NO}" -lt 10 ];then
      TS_NO_XX=0${TS_NO}
  else
      TS_NO_XX=${TS_NO}
  fi
  TS_CTRL_FILE_NAME=${TS_CTRL_FILE_NAME_1}_${TS_NO_XX}.cnt
  TS_CTRL_FILE=${TS_CTRL_FILE_PATH}/${TS_CTRL_FILE_NAME}
  if [ -r "${TS_CTRL_FILE}" ];then
#20121218�C��START
      NAME_1[${TS_NO}]=`sed -n '1p' ${TS_CTRL_FILE}`
      TS_DAT_DEST_NAME[${TS_NO}]=`echo ${NAME_1[${TS_NO}]}|awk -F, '{print $4}'`
      NAME_2[${TS_NO}]=`sed -n '2p' ${TS_CTRL_FILE}`
      TS_END_DEST_NAME[${TS_NO}]=`echo ${NAME_2[${TS_NO}]}|awk -F, '{print $4}'`
      TS_DAT_MAE_NAME[${TS_NO}]=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_XX}.gz
      TS_END_MAE_NAME[${TS_NO}]=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_XX}.ctl
#20121218�C��END
      TS_MAX_NO_ID=${TS_NO}
      let TS_NO=TS_NO+1
  else
      if [ "${TS_NO}" = "1" ];then
          echo "����t�@�C��:"${TS_CTRL_FILE}"���݂��Ȃ�"   >> ${TS_LOGFILE}
      fi
      break
  fi
done

if [ "${TS_NO}" = "1" ];then
    TS_STATUS=16
else
    TS_STATUS=0
fi

if [ "${TS_STATUS}" = "0" ];then
    if [ -d "${TS_FLG_FILE_PATH}" ]; then
        TS_SERVE_FILE=(`find ${TS_FLG_FILE_PATH} -type f -maxdepth 1| awk -F/ '{print $NF}'`)
        TS_SERVE_FILE_CNT=(`find ${TS_FLG_FILE_PATH} -type f -maxdepth 1| grep -c "/"`)
        if [ "${TS_SERVE_FILE_CNT}" = "0" ];then
            echo "�������Ă���z�M�T�[�o�t�@�C����0��"                    >> ${TS_LOGFILE}
            TS_STATUS=16
        else
            TS_STATUS=0
            TS_SERVE_NO=0
            TS_SEND_SERVE=${TS_SERVE_FILE[0]}
            while [ "${TS_SERVE_NO}" -lt "${TS_SERVE_FILE_CNT}" ]
            do
              if [ "${TS_DEF_SERVE_NAME}" = "${TS_SERVE_FILE[${TS_SERVE_NO}]}" ]; then
                  TS_SEND_SERVE=${TS_DEF_SERVE_NAME}
                  break
              fi
              let TS_SERVE_NO=TS_SERVE_NO+1
            done
        fi
    else
        echo "�����t���O�t�@�C���̃p�X:"${TS_FLG_FILE_PATH}"���݂��Ȃ�"   >> ${TS_LOGFILE}
        TS_STATUS=16
    fi
fi

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=9
    echo "���^�[���R�[�h="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#�X�e�b�v-0030 ���M�ꗗTMP�t�@�C��
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#���
TS_KJN_YMD=${SJ_PEX_DATE}
#���M�ꗗTMP�t�@�C���̃p�X
TS_TEMP_FILE_PATH=${APL_TMP_DIR}
#���M�ꗗTMP�t�@�C����
TS_TEMP_FILE_NAME=${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}.tmp
TS_TEMP_FILE=${TS_TEMP_FILE_PATH}/${TS_TEMP_FILE_NAME}
TS_FTP_COUNT_FAIL=0

if [ -r "${TS_TEMP_FILE}" ];then
    TS_STATUS=0
    TS_NO_ID=0
    while [ "${TS_NO_ID}" -lt "${TS_MAX_NO_ID}" ]
    do
      let TS_NO_ID=TS_NO_ID+1
      if [ "${TS_NO_ID}" -lt 10 ];then
          TS_NO_ID_XX=0${TS_NO_ID}
      else
          TS_NO_ID_XX=${TS_NO_ID}
      fi
      if [ ! -r "${APL_FTP_DIR}/${TS_DAT_MAE_NAME[${TS_NO_ID}]}" ];then
          continue
      fi
      while read TS_SEND_LINE
      do
        if [ "${TS_SEND_LINE}" = "" ];then
            break
        fi
        TS_SEND_ID=`echo ${TS_SEND_LINE}|awk -F, '{print $1}'`
        TS_DAT_FILE_FTP_DIR=`echo ${TS_SEND_LINE}|awk -F, '{print $2}'`
        TS_CTRL_FILE_FTP_DIR=`echo ${TS_SEND_LINE}|awk -F, '{print $3}'`

#�@PUT�O��t�@�C�����擾
#���M�t�@�C��
        TS_SEND_PUT_MAE_NAME=${TS_DAT_MAE_NAME[${TS_NO_ID}]}
        case ${TS_EXECID} in
        T7071US) TS_SEND_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7070US_${TS_NO_ID_XX}.gz.${TS_SEND_ID}
                 TS_SEND_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7070US_${TS_NO_ID_XX}.gz;;
        T7106US) TS_SEND_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7105US_${TS_NO_ID_XX}.gz.${TS_SEND_ID}
                 TS_SEND_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7105US_${TS_NO_ID_XX}.gz;;
        T7166US) TS_SEND_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7165US_${TS_NO_ID_XX}.gz.${TS_SEND_ID}
                 TS_SEND_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7165US_${TS_NO_ID_XX}.gz;;
        *)       TS_SEND_PUT_ATO_NAME=${TS_DAT_MAE_NAME[${TS_NO_ID}]}.${TS_SEND_ID}
                 TS_SEND_PUT_WRK_NAME=${TS_DAT_MAE_NAME[${TS_NO_ID}]};;
        esac

#END�t�@�C��
        TS_END_PUT_MAE_NAME=${TS_END_MAE_NAME[${TS_NO_ID}]}
        case ${TS_EXECID} in
        T7071US) TS_END_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7070US_${TS_NO_ID_XX}.ctl.${TS_SEND_ID}
                 TS_END_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7070US_${TS_NO_ID_XX}.ctl;;
        T7106US) TS_END_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7105US_${TS_NO_ID_XX}.ctl.${TS_SEND_ID}
                 TS_END_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7105US_${TS_NO_ID_XX}.ctl;;
        T7166US) TS_END_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7165US_${TS_NO_ID_XX}.ctl.${TS_SEND_ID}
                 TS_END_PUT_WRK_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7165US_${TS_NO_ID_XX}.ctl;;
        *)       TS_END_PUT_ATO_NAME=${TS_END_MAE_NAME[${TS_NO_ID}]}.${TS_SEND_ID}
                 TS_END_PUT_WRK_NAME=${TS_END_MAE_NAME[${TS_NO_ID}]};;
        esac

#����t�@�C��
        TS_CTRL_PUT_MAE_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_ID_XX}.${TS_SEND_ID}.cnt
        case ${TS_EXECID} in
        T7071US) TS_CTRL_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7070US_${TS_NO_ID_XX}.${TS_SEND_ID}.cnt;;
        T7106US) TS_CTRL_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7105US_${TS_NO_ID_XX}.${TS_SEND_ID}.cnt;;
        T7166US) TS_CTRL_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_T7165US_${TS_NO_ID_XX}.${TS_SEND_ID}.cnt;;
        *)       TS_CTRL_PUT_ATO_NAME=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_ID_XX}.${TS_SEND_ID}.cnt;;
        esac

TS_SEND_PUT_FILE=${APL_FTP_DIR}/${TS_SEND_PUT_MAE_NAME}
TS_END_PUT_FILE=${APL_FTP_DIR}/${TS_END_PUT_MAE_NAME}
        if [ -r "${TS_SEND_PUT_FILE}" -a -r "${TS_END_PUT_FILE}" ];then
#�A����t�@�C���쐬
        TS_CTRL_FILE_CREAT_PATH=${APL_FTP_DIR}
        TS_CTRL_FILE_CREAT=${TS_CTRL_FILE_CREAT_PATH}/${TS_CTRL_PUT_MAE_NAME}
#20121218�C��START
        case ${TS_EXECID} in
        T7071US|T7106US|T7166US) echo ${TS_SEND_PUT_ATO_NAME}","${TS_SEND_ID}",0,"${TS_SEND_PUT_WRK_NAME}  > ${TS_CTRL_FILE_CREAT}
        	                       echo ${TS_END_PUT_ATO_NAME}","${TS_SEND_ID}",0,"${TS_END_PUT_WRK_NAME}  >> ${TS_CTRL_FILE_CREAT};;
        *)                       echo ${TS_DAT_MAE_NAME[${TS_NO_ID}]}"."${TS_SEND_ID}","${TS_SEND_ID}",0,"${TS_DAT_DEST_NAME[${TS_NO_ID}]}  > ${TS_CTRL_FILE_CREAT}
        	                       echo ${TS_END_MAE_NAME[${TS_NO_ID}]}"."${TS_SEND_ID}","${TS_SEND_ID}",0,"${TS_END_DEST_NAME[${TS_NO_ID}]}  >> ${TS_CTRL_FILE_CREAT};;
        esac
#20121218�C��END


#�BFTP�R�}���h�t�@�C������
#COUNT
TS_FTP_COUNT=0
TS_FTP_COUNT_1=""
#�W���uID
TS_JOB_ID=BCZY0020
#FTP�]���t�@�C��
#20120703�C��START
TS_FTPFILE=${APL_TMP_DIR}/BCZY0020_${TS_EXECID}_${TS_JOB_ID}_${TS_KJN_YMD}_${TS_RIYO_CMPCD}_${TS_KIDOID}_${TS_SEND_ID}.tmp
#20120703�C��END
#APL_FTP_DIR��"/"�ɂ������"\/"
TS_APL_FTP_DIR=`echo ${APL_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#TS_DAT_FILE_FTP_DIR��"/"�ɂ������"\/"
TS_DAT_FILE_FTP_DIR_1=`echo ${TS_DAT_FILE_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#TS_CTRL_FILE_FTP_DIR��"/"�ɂ������"\/"
TS_CTRL_FILE_FTP_DIR_1=`echo ${TS_CTRL_FILE_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#FTP��������I���t���O
TS_END_FLG=0

        while [ "${TS_END_FLG}" != "1" ]
        do
          if [ "${TS_SEND_SERVE}" = " " ];then
              if [ "${TS_SERVE_FILE_CNT}" = "0" ];then
                  TS_STATUS=16
                  break
              fi
              TS_SEND_SERVE=${TS_SERVE_FILE[0]}
          fi
          TS_HOST=`eval echo '$'$TS_SEND_SERVE`
          FTP_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${TS_RIYO_CMPCD}_${SJ_PEX_DATE}_${TS_KIDOID}_${TS_SEND_SERVE}.log
          while [ "${TS_FTP_COUNT}" != "3" ]
          do
            if [ -r "${APL_DATEFILE_DIR}/BCZY0020.dat" ];then
                sed "s/open FTP_RX_HOST/open ${TS_HOST}/" ${APL_DATEFILE_DIR}/BCZY0020.dat |sed \
                "s/cd DATADIR/cd ${TS_DAT_FILE_FTP_DIR_1}"/ |sed \
                "s/put SOUSINFILE_MAE SOUSINFILE_ATO/put ${TS_APL_FTP_DIR}\/${TS_SEND_PUT_MAE_NAME} ${TS_SEND_PUT_ATO_NAME}/" |sed \
                "s/put ENDFILE_MAE ENDFILE_ATO/put ${TS_APL_FTP_DIR}\/${TS_END_PUT_MAE_NAME} ${TS_END_PUT_ATO_NAME}/" |sed \
                "s/cd CONTROLDIR/cd ${TS_CTRL_FILE_FTP_DIR_1}/" |sed \
                "s/put SEIGYOFILE_MAE SEIGYOFILE_ATO/put ${TS_APL_FTP_DIR}\/${TS_CTRL_PUT_MAE_NAME} ${TS_CTRL_PUT_ATO_NAME}/" >${TS_FTPFILE}
                TS_STATUS=$?
                if [ "${TS_STATUS}" != "0" ];then
                    echo "FTP�R�}���h�t�@�C��:"${TS_FTPFILE}"�쐬�G���["   >> ${TS_LOGFILE}
                    break
                fi
            else
                TS_STATUS=16
                echo "FTP�R�}���h�t�@�C��:"${APL_DATEFILE_DIR}"/BCZY0020.dat���݂��Ȃ�"   >> ${TS_LOGFILE}
                break
            fi

#�CFTP
ftp -niv <${TS_FTPFILE}                           >> ${FTP_LOGFILE} 2>&1

#�A���^�C���A�E�g(Connection timed out)
#�e�s�o�T�[�o���s��(unknown host�ANot connected)
#�e�s�o���[�U�[��/�p�X���[�h�s��(Login incorrect)
#�t�@�C���]���T�[�o�̃p�X�s��(The system cannot find the path specified.)
#FTP�R�}���h�t�@�C���Œu�����ꂽ������s��(No such file or directory)
          let TS_FTP_COUNT_1=`grep -c -i "fail" ${FTP_LOGFILE}`+\
`grep -c -i "Connection refused" ${FTP_LOGFILE}`+\
`grep -c -i "Connection timed out" ${FTP_LOGFILE}`+\
`grep -c -i "unknown host" ${FTP_LOGFILE}`+\
`grep -c -i "Not connected" ${FTP_LOGFILE}`+\
`grep -c -i "Login incorrect" ${FTP_LOGFILE}`+\
`grep -c -i "cannot" ${FTP_LOGFILE}`+\
`grep -c -i "Service not available" ${FTP_LOGFILE}`+\
`grep -c -i "No such file or directory" ${FTP_LOGFILE}`                 >> ${FTP_LOGFILE} 2>&1

            if [ "${TS_FTP_COUNT_1}" = "${TS_FTP_COUNT_FAIL}" ];then
                TS_STATUS=0
                TS_FTP_COUNT=3
            else
                let TS_FTP_COUNT_FAIL=TS_FTP_COUNT_1
                TS_STATUS=16
                let TS_FTP_COUNT=TS_FTP_COUNT+1
                if [ "${TS_FTP_COUNT}" != "3" ];then
                    sleep 60
                fi
            fi
          done
          if  [ "${TS_STATUS}" != "0" ];then
             TS_FTP_COUNT_FAIL=0
             mv ${TS_FLG_FILE_PATH}/${TS_SEND_SERVE} ${TS_BKUP_PATH}    >> ${TS_LOGFILE} 2>&1
             TS_STATUS=$?
             if [ "${TS_STATUS}" != "0" ];then
                 break
             else
                 TS_SERVE_FILE=(`find ${TS_FLG_FILE_PATH} -type f -maxdepth 1| awk -F/ '{print $NF}'`)
                 TS_SERVE_FILE_CNT=(`find ${TS_FLG_FILE_PATH} -type f -maxdepth 1| grep -c "/"`)
                 TS_SEND_SERVE=" "
                 TS_FTP_COUNT=0
             fi
          else
             TS_END_FLG=1
          fi
        done
        else
          if [ -r "${TS_SEND_PUT_FILE}"  ];then
             let TS=1
          else
             echo "�f�X�e�B�l�[�V�����t�@�C��:"${TS_SEND_PUT_FILE}"���݂��Ȃ�"   >> ${TS_LOGFILE}
          fi
          if [ -r "${TS_END_PUT_FILE}" ];then
            let TS=1
          else
             echo "�f�X�e�B�l�[�V�����t�@�C��:"${TS_END_PUT_FILE}"���݂��Ȃ�"     >> ${TS_LOGFILE}
          fi
          TS_STATUS=16
          break
        fi
        if  [ "${TS_STATUS}" != "0" ];then
           break
        fi
      done<${TS_TEMP_FILE}
        if  [ "${TS_STATUS}" != "0" ];then
           break
        fi
    done
else
    TS_STATUS=1
    echo "���M�ꗗTMP�t�@�C��:"${TS_TEMP_FILE}"���݂��Ȃ�"   >> ${TS_LOGFILE}
fi
if [ "${TS_STATUS}" != "0" ];then
    TS_STATUS=16
fi

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
#GX�T�[�oFTP����  END
#-----------------------------------------------------------------------------------------
if [ "${TS_STATUS}" = "0" ];then
    TS_RCODE=0
else
    TS_RCODE=9
    echo "���^�[���R�[�h="${TS_RCODE}             >> ${TS_LOGFILE}
fi

BCZC9999.sh ${TS_RCODE}                           >> ${TS_LOGFILE}
exit ${TS_RCODE}
