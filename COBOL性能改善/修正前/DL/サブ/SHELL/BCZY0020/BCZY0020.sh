#! /bin/sh
#-----------------------------------------------------------------------------------------
# システムＩＤ      ：  TSTAR
# システム名称      ：  次期TSTARシステム
# モジュールＩＤ    ：  BCZY0020
# モジュール名称    ：  GXサーバFTP処理
# 処理概要          ：  GXサーバFTP処理
# 引数              ：  ARG1: go
#                       ARG2: ファイル種別
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  --------------------------------------
# 20080820  新規    SCS
# 20100415  修改    SCS     常　峰 　仕様変更302、シェルの最後でリネームする。
# 20100805  修改    SCS     常　峰 　テーマ2818対応
# 20120703  修改    SCS     高志軍 　
# 20121218  修改    ISC     蒋小波 　テーマ3421対応
# 20130709  修正    SCS     シャ建   テーマ3545-1
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------
#GXサーバFTP処理    START
#-----------------------------------------------------------------------------------------
#ローカル変数設定
#-----------------------------------------------------------------------------------------
#メインログファイル
#TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}_${TS_KIDOID}.log

#シェルのリターンコード
TS_RCODE=0

#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
BCZC0000.sh                                       >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
#引数確認
#-----------------------------------------------------------------------------------------
if [ "$1" != "go" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
    TS_RCODE=9
    echo "リターンコード="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
if [ "$2" = "" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
    TS_RCODE=9
    echo "リターンコード="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
#-----------------------------------------------------------------------------------------
#ステップ-0010 MCZY7170送信ID取得メイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#MCZY7170送信ID取得メイン
MCZY7170 ${TS_RIYO_CMPCD} $2 ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}       >> ${TS_LOGFILE} 2>&1
TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=9
    echo "リターンコード="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#ステップ-0020 制御ファイルの内容を取得する
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#基準日
TS_KJN_YMD=${SJ_PEX_DATE}
#制御ファイルのパス
TS_CTRL_FILE_PATH=${APL_TMP_DIR}
#制御ファイル名
TS_CTRL_FILE_NAME_1=${TS_RIYO_CMPCD}_${SJ_PEX_DATE}_${TS_KIDOID}_SCZY7180
#連番
TS_NO=1
#生存フラグファイルのパス
TS_FLG_FILE_PATH=${NAS_APL_DIR}/C000/ftp
#bkupフォルダ
TS_BKUP_PATH=${NAS_APL_DIR}/C000/ftp/bkup
#デフォールト配信サーバ名
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
#20121218修正START
      NAME_1[${TS_NO}]=`sed -n '1p' ${TS_CTRL_FILE}`
      TS_DAT_DEST_NAME[${TS_NO}]=`echo ${NAME_1[${TS_NO}]}|awk -F, '{print $4}'`
      NAME_2[${TS_NO}]=`sed -n '2p' ${TS_CTRL_FILE}`
      TS_END_DEST_NAME[${TS_NO}]=`echo ${NAME_2[${TS_NO}]}|awk -F, '{print $4}'`
      TS_DAT_MAE_NAME[${TS_NO}]=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_XX}.gz
      TS_END_MAE_NAME[${TS_NO}]=RX${TS_RIYO_CMPCD}_${TS_KJN_YMD}_${TS_KIDOID}_${TS_EXECID}_${TS_NO_XX}.ctl
#20121218修正END
      TS_MAX_NO_ID=${TS_NO}
      let TS_NO=TS_NO+1
  else
      if [ "${TS_NO}" = "1" ];then
          echo "制御ファイル:"${TS_CTRL_FILE}"存在しない"   >> ${TS_LOGFILE}
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
            echo "生存している配信サーバファイルは0件"                    >> ${TS_LOGFILE}
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
        echo "生存フラグファイルのパス:"${TS_FLG_FILE_PATH}"存在しない"   >> ${TS_LOGFILE}
        TS_STATUS=16
    fi
fi

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=9
    echo "リターンコード="${TS_RCODE}             >> ${TS_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#ステップ-0030 送信一覧TMPファイル
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#基準日
TS_KJN_YMD=${SJ_PEX_DATE}
#送信一覧TMPファイルのパス
TS_TEMP_FILE_PATH=${APL_TMP_DIR}
#送信一覧TMPファイル名
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

#①PUT前後ファイル名取得
#送信ファイル
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

#ENDファイル
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

#制御ファイル
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
#②制御ファイル作成
        TS_CTRL_FILE_CREAT_PATH=${APL_FTP_DIR}
        TS_CTRL_FILE_CREAT=${TS_CTRL_FILE_CREAT_PATH}/${TS_CTRL_PUT_MAE_NAME}
#20121218修正START
        case ${TS_EXECID} in
        T7071US|T7106US|T7166US) echo ${TS_SEND_PUT_ATO_NAME}","${TS_SEND_ID}",0,"${TS_SEND_PUT_WRK_NAME}  > ${TS_CTRL_FILE_CREAT}
        	                       echo ${TS_END_PUT_ATO_NAME}","${TS_SEND_ID}",0,"${TS_END_PUT_WRK_NAME}  >> ${TS_CTRL_FILE_CREAT};;
        *)                       echo ${TS_DAT_MAE_NAME[${TS_NO_ID}]}"."${TS_SEND_ID}","${TS_SEND_ID}",0,"${TS_DAT_DEST_NAME[${TS_NO_ID}]}  > ${TS_CTRL_FILE_CREAT}
        	                       echo ${TS_END_MAE_NAME[${TS_NO_ID}]}"."${TS_SEND_ID}","${TS_SEND_ID}",0,"${TS_END_DEST_NAME[${TS_NO_ID}]}  >> ${TS_CTRL_FILE_CREAT};;
        esac
#20121218修正END


#③FTPコマンドファイル生成
#COUNT
TS_FTP_COUNT=0
TS_FTP_COUNT_1=""
#ジョブID
TS_JOB_ID=BCZY0020
#FTP転送ファイル
#20120703修正START
TS_FTPFILE=${APL_TMP_DIR}/BCZY0020_${TS_EXECID}_${TS_JOB_ID}_${TS_KJN_YMD}_${TS_RIYO_CMPCD}_${TS_KIDOID}_${TS_SEND_ID}.tmp
#20120703修正END
#APL_FTP_DIRの"/"にかわって"\/"
TS_APL_FTP_DIR=`echo ${APL_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#TS_DAT_FILE_FTP_DIRの"/"にかわって"\/"
TS_DAT_FILE_FTP_DIR_1=`echo ${TS_DAT_FILE_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#TS_CTRL_FILE_FTP_DIRの"/"にかわって"\/"
TS_CTRL_FILE_FTP_DIR_1=`echo ${TS_CTRL_FILE_FTP_DIR}|sed s/'\/'/'\\\\\/'/g`
#FTP処理正常終了フラグ
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
                    echo "FTPコマンドファイル:"${TS_FTPFILE}"作成エラー"   >> ${TS_LOGFILE}
                    break
                fi
            else
                TS_STATUS=16
                echo "FTPコマンドファイル:"${APL_DATEFILE_DIR}"/BCZY0020.dat存在しない"   >> ${TS_LOGFILE}
                break
            fi

#④FTP
ftp -niv <${TS_FTPFILE}                           >> ${FTP_LOGFILE} 2>&1

#連結タイムアウト(Connection timed out)
#ＦＴＰサーバ名不正(unknown host、Not connected)
#ＦＴＰユーザー名/パスワード不正(Login incorrect)
#ファイル転送サーバのパス不正(The system cannot find the path specified.)
#FTPコマンドファイルで置換された文字列不正(No such file or directory)
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
             echo "デスティネーションファイル:"${TS_SEND_PUT_FILE}"存在しない"   >> ${TS_LOGFILE}
          fi
          if [ -r "${TS_END_PUT_FILE}" ];then
            let TS=1
          else
             echo "デスティネーションファイル:"${TS_END_PUT_FILE}"存在しない"     >> ${TS_LOGFILE}
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
    echo "送信一覧TMPファイル:"${TS_TEMP_FILE}"存在しない"   >> ${TS_LOGFILE}
fi
if [ "${TS_STATUS}" != "0" ];then
    TS_STATUS=16
fi

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
#GXサーバFTP処理  END
#-----------------------------------------------------------------------------------------
if [ "${TS_STATUS}" = "0" ];then
    TS_RCODE=0
else
    TS_RCODE=9
    echo "リターンコード="${TS_RCODE}             >> ${TS_LOGFILE}
fi

BCZC9999.sh ${TS_RCODE}                           >> ${TS_LOGFILE}
exit ${TS_RCODE}
