#! /bin/sh
#-----------------------------------------------------------------------------------------
# サブシステムＩＤ  ：  GAMMA残高データ生成起動
# サブシステム名称  ：  次期TSTARシステム
# モジュールＩＤ    ：  BUSG1020
# モジュール名称    ：  GAMMA残高データ生成
# 処理概要          ：  GAMMA残高データ生成
# 引数              ：  ARG1：go
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    担当     内容
# --------  ----    ------  -------  -----------------------------
# 20080908  新規    SCS     顧義鋒 　新規作成
# 20090408  修正    SCS     劉新文   残タスク対応（194）
# 20091215  修正    SCS     黄剣鵬   連結障害対応（2179）
# 20130709  修正    SCS     潘遠     テーマ3545-1
# 20130808  修正    SCS     潘遠     テーマ3541
#
# Copyright (C) 2008 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# ローカル変数設定
#-----------------------------------------------------------------------------------------

#MCZY7070の引数
#セッション区分（１：先頭セッション）
TS_SESSION_KBN_1="1"
#セッション区分（2：終了セッション）
TS_SESSION_KBN_2="2"
#アップロード総件数（0）
TS_UPLOAD_CNT="0"
#アップロードエラー件数（0）
TS_UPLERR_CNT="0"
#DLファイル出力区分（スペース）
TS_OUTFILE_KBN_B=" "
TS_OUTFILE_KBN_SPACE=" "
TS_OUTFILE_KBN_9="9"
#BCZY0020リターンコード
TS_BCZY0020_RCODE=0
TS_BCZY0020_CALL=0
#存在FLG
TS_FILE_SONZAI=0
#FILEのTS_SIZE
TS_SIZE=0
#シェルのリターンコード
TS_RCODE=0
#サーバのリターンコード
TS_STATUS_20=0
TS_STATUS_240=0
#正常
CNS_NORMAL=0
#警告
CNS_WARNING=2
#業務エラー（続行可能）
CNS_GYOUMUERR_GO=4
#業務エラー（明細続行不可）
CNS_GYOUMUERR_MEISAISTOP=6
#業務エラー（処理中メイン続行不可）
CNS_GYOUMUERR_MAINSTOP=8
#業務エラー（続行不可）
CNS_GYOUMUERR_STOP=10
#システムエラー
CNS_SYSTEMERR=16
#シェルエラー
CNS_SHELLERR=90

#連番
CNS_NO_ID_1=01
CNS_NO_ID_2=02
CNS_NO_ID_3=03
CNS_NO_ID_4=04
CNS_NO_ID_5=05
CNS_NO_ID_6=06
CNS_NO_ID_7=07
CNS_NO_ID_8=08
#-------------------------------------------------------------------------------
# 引数確認
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
# ステップ-0010 利用会社コード、処理実行日、起動ID、業務タスクID 取得
#-----------------------------------------------------------------------------------------
TS_STEPID=0010

TS_STEP_RCODE=0

#利用会社コード　←　環境変数TS_RIYO_CMPCD
if [ "${TS_RIYO_CMPCD}" != "" ];then
    TS_RIYOCMP_CD_SH=`echo ${TS_RIYO_CMPCD}`
else
    TS_RCODE=1
    echo "利用会社コード取得失敗"
fi

#処理実行日　←　環境変数SJ_PEX_DATE
if [ "${SJ_PEX_DATE}" != "" ];then
    TS_PEX_DATE_SH=`echo ${SJ_PEX_DATE}`
else
    TS_RCODE=1
    echo "処理実行日取得失敗"
fi

#起動ID　←　環境変数TS_KIDOID
if [ "${TS_KIDOID}" != "" ];then
    TS_KIDO_ID_SH=`echo ${TS_KIDOID}`
else
    TS_RCODE=1
    echo "起動ID取得失敗"
fi

#業務タスクID　←　環境変数TS_EXECID
if [ "${TS_EXECID}" != "" ];then
    TS_EXEC_ID_SH=`echo ${TS_EXECID}`
else
    TS_RCODE=1
    echo "業務タスクID取得失敗"
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
echo "*** GAMMA残高データ生成起動 *** "                                                         >> $TS_LOGFILE


BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********利用会社コード、処理実行日、起動ID、業務タスクID取得*******"                    >> $TS_LOGFILE
echo "利用会社コード = ${TS_RIYOCMP_CD_SH}"                                                        >> $TS_LOGFILE
echo "処理実行日     = ${TS_PEX_DATE_SH}"                                                          >> $TS_LOGFILE
echo "起動ID         = ${TS_KIDO_ID_SH}"                                                           >> $TS_LOGFILE
echo "業務タスクID   = ${TS_EXEC_ID_SH}"                                                           >> $TS_LOGFILE
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE


#-----------------------------------------------------------------------------------------
# ステップ-0020 実行状況管理UPDメイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************** 実行状況管理UPDメイン ************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
TS_STATUS_20=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：セッション区分（１：先頭セッション）
#引数５：アップロード総件数（0）
#引数６：アップロードエラー件数（0）
#引数７：DLファイル出力区分（スペース)
echo "MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} \
               ${TS_SESSION_KBN_1} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"       >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_SESSION_KBN_1} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                  >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo  "【MCZY7070】(セッション区分=1) 戻り値＝${TS_STATUS}"                                     >> $TS_LOGFILE
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
fi

BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
TS_STATUS_20=${TS_STATUS}

#-----------------------------------------------------------------------------------------
# ステップ-0030 GAMMA残高データ生成
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0030
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** GAMMA残高データ生成 **************************"                >> $TS_LOGFILE

    TS_STEP_RCODE=0
    #引数１：利用会社コード（STEP1取得）
    #引数２：処理実行日（STEP1取得）
    #引数３：業務タスクID（STEP1取得）
    #引数４：起動ID（STEP1取得）

    echo "MUSR2651 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}"                   >> $TS_LOGFILE

    MUSR2651 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}                          >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    echo "MUSR2651 戻り値＝${TS_STATUS}"                                                        >> $TS_LOGFILE
    case $TS_STATUS in
    #正常
    0)TS_STEP_RCODE=${CNS_NORMAL}
      echo "正常終了"                                                                           >> $TS_LOGFILE
    ;;
    #警告
    2)TS_STEP_RCODE=${CNS_WARNING}
      echo "警告終了"                                                                           >> $TS_LOGFILE
    ;;
    #業務エラー(続行可)
    4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
      echo "業務エラー(続行可)終了"                                                             >> $TS_LOGFILE
    ;;
    #業務エラー（明細続行不可）
    6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
      echo "業務エラー（明細続行不可）終了"                                                     >> $TS_LOGFILE
    ;;
    #業務エラー（処理中メイン続行不可）
    8)TS_STEP_RCODE=${CNS_GYOUMUERR_MAINSTOP}
      echo "業務エラー（処理中メイン続行不可）終了"                                             >> $TS_LOGFILE
    ;;
    #業務エラー(続行不可)
    10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
      echo "業務エラー(続行不可)終了"                                                           >> $TS_LOGFILE
    ;;
    #システムエラー
    16)TS_RCODE=1
       TS_STEP_RCODE=${CNS_SYSTEMERR}
       echo "システムエラー終了"                                                                >> $TS_LOGFILE
    ;;
    *)TS_RCODE=1
      TS_STEP_RCODE=${CNS_SYSTEMERR}
    ;;
    esac
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#-----------------------------------------------------------------------------------------
# ステップ-0031  非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0031
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#######    連結障害493の対応  20080105 修正  開始    ############
#-----------------------------------------------------------------------------------------
# ステップ-0033 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0033
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_01_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#######    連結障害493の対応  20080105 修正  終了    ############

#-----------------------------------------------------------------------------------------
# ステップ-0040 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0040
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                    echo "圧縮失敗"                                                              >> $TS_LOGFILE
                else
                    echo "圧縮成功"                                                              >> $TS_LOGFILE
                fi
             else
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "ファイル存在しません"                                                      >> $TS_LOGFILE
             fi
              cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0050 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0050
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0061 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0061
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK**************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#######    連結障害493の対応  20080105 修正  開始    ############
#-----------------------------------------------------------------------------------------
# ステップ-0063 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0063
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_02_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#######    連結障害493の対応  20080105 修正  終了    ############


#-----------------------------------------------------------------------------------------
# ステップ-0070 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0070
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0080 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0080
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# ステップ-0091 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0091
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0093 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0093
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_03_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0094 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0094
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0095 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0095
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# ステップ-0097 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0097
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0099 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0099
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_04_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0100 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0100
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0101 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0102
        BCZC1100.sh ${TS_STEPID}                                                                >> $TS_LOGFILE
        echo "*********************************************************************"            >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"            >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                      >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                      >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                               >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0110 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0110
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0111 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0111
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_05_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0112 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0112
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0113 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0113
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0120 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0120
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0121 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0121
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_06_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0122 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0122
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0123 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0123
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0130 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0130
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0131 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0131
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_07_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0132 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0132
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0133 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0133
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi
#-----------------------------------------------------------------------------------------
# ステップ-0140 非零FILE 存在 CHECK
#-----------------------------------------------------------------------------------------
if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0140
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "********************** 非零FILE 存在 CHECK **************************"                >> $TS_LOGFILE
    TS_STEP_RCODE=0
    FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08
    TS_FILE_SONZAI=0
    if [ -f ${FILENAME} ];then
      TS_FILE_SONZAI=1
      echo   ${FILENAME}"存在 "                                                                >> $TS_LOGFILE
    else
      echo   ${FILENAME}"存在しない"                                                            >> $TS_LOGFILE
    fi
    if [ ${TS_FILE_SONZAI} -eq  1 ];then
        TS_SIZE=`ls -l ${FILENAME} | awk '{print $5}'`
        echo ${FILENAME}"のSIZE="${TS_SIZE}                                                        >> $TS_LOGFILE
        if [ ${TS_SIZE} -gt 0 ];then
          TS_FILE_SONZAI=1
          echo   ${FILENAME}"のSIZE > 0 "                                                           >> $TS_LOGFILE
        else
          echo   ${FILENAME}"のSIZE = 0"                                                            >> $TS_LOGFILE
          TS_FILE_SONZAI=0
        fi
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi
#-----------------------------------------------------------------------------------------
# ステップ-0141 ファイル出力フォーマット統一
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0141
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************* ファイル出力フォーマット統一 **************"                >> $TS_LOGFILE

        TS_STEP_RCODE=0
        FILENAME=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08
        FILENAME_BAK=${APL_FTP_DIR}/RX${TS_RIYOCMP_CD_SH}_${TS_PEX_DATE_SH}_${TS_KIDO_ID_SH}_${TS_EXEC_ID_SH}_08_TMP
    #sed
        cat ${FILENAME} | tr -d "\000" | sed 's/ *\t/\t/g' > ${FILENAME_BAK}

    #sed返回値判定
        TS_STATUS=$?
        echo "sed 戻り値＝${TS_STATUS}"                                                             >> $TS_LOGFILE
        if [ "$TS_STATUS" != "0" ]
        then
            TS_STEP_RCODE=${CNS_SHELLERR}
            TS_RCODE=1
            echo "sedエラー"                                                                        >> $TS_LOGFILE
        else
            echo "sed正常"                                                                          >> $TS_LOGFILE
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #rm
            rm -f ${FILENAME}                                                                       >> $TS_LOGFILE  2>&1

    #rm返回値判定
            TS_STATUS=$?
            echo "rm 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "rmエラー"                                                                     >> $TS_LOGFILE
            else
                echo "rm正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    #mv
            mv ${FILENAME_BAK} ${FILENAME}                                                          >>$TS_LOGFILE  2>&1
    #mv返回値判定
            TS_STATUS=$?
            echo "mv 戻り値＝${TS_STATUS}"                                                          >> $TS_LOGFILE
            if [ "$TS_STATUS" != "0" ]
            then
                TS_STEP_RCODE=${CNS_SHELLERR}
                TS_RCODE=1
                echo "mvエラー"                                                                     >> $TS_LOGFILE
            else
                echo "mv正常"                                                                       >> $TS_LOGFILE
            fi
        fi

        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0142 ファイル圧縮
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
     if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
         TS_STEPID=0142
         BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
         echo "*********************************************************************"                >> $TS_LOGFILE
         echo "************************* ファイル圧縮処理 **************************"                >> $TS_LOGFILE

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
                     echo "圧縮失敗"                                                              >> $TS_LOGFILE
                 else
                     echo "圧縮成功"                                                              >> $TS_LOGFILE
                 fi
              else
                 TS_STEP_RCODE=${CNS_SHELLERR}
                 TS_RCODE=1
                 echo "ファイル存在しません"                                                      >> $TS_LOGFILE
              fi
               cd ${HERE}
         fi
         BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
     fi
fi

#-----------------------------------------------------------------------------------------
# ステップ-0143 ENDファイル作成
#-----------------------------------------------------------------------------------------
if [ ${TS_FILE_SONZAI} -eq  1 ];then
    if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
        TS_STEPID=0143
        BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
        echo "*********************************************************************"                >> $TS_LOGFILE
        echo "************************ ENDファイル作成 ****************************"                >> $TS_LOGFILE

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
                echo "ENDファイル作成失敗"                                                          >> $TS_LOGFILE
            else
                echo "ENDファイル作成成功"                                                          >> $TS_LOGFILE
            fi
            cd ${HERE}
        fi
        BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
    fi
fi

##-----------------------------------------------------------------------------------------
## ステップ-0240 外接データマージ検知処理
##-----------------------------------------------------------------------------------------
TS_STEPID=0240
BCZC1100.sh ${TS_STEPID}     	                                                                >> $TS_LOGFILE
TS_STATUS_240=0
KAISYA_FILE="GX_COPY_LIST.dat"
#引数１：利用会社 (TS_RIYO_CMPCD)
#引数２：処理実行日 (SJ_PEX_DATE)
#引数３：業務タスクID (TS_EXECID)
#引数４：起動ID (TS_KIDOID)

grep -q "${TS_RIYO_CMPCD}" ${APL_DATEFILE_DIR}/${KAISYA_FILE}                                   >> $TS_LOGFILE  2>&1
if [[ $? -eq 0 ]];then
    echo "会社が存在する"                                                                       >> $TS_LOGFILE
  #echo "MDYJ2201 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_EXECID} ${TS_KIDOID}                     >> $TS_LOGFILE

  MDYJ2201 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_EXECID} ${TS_KIDOID}                            >> $TS_LOGFILE  2>&1

  TS_STATUS_240=$?
  echo "MDYJ2201 戻り値＝${TS_STATUS_240}"                                                      >> $TS_LOGFILE

  if [ "${TS_STATUS_240}" != "0" ];then
      TS_RCODE=1
      TS_STATUS_240=${CNS_SYSTEMERR}
  fi
else
  echo "会社が存在しない"                                                                       >> $TS_LOGFILE
fi

BCZC1199.sh ${TS_STEPID} ${TS_STATUS_240}                                                       >> $TS_LOGFILE

#-----------------------------------------------------------------------------------------
# ステップ-0210 GXサーバFTP処理
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
	  TS_BCZY0020_CALL=1
    TS_STEP_RCODE=0
    TS_STEPID=0210
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "*********************** GXサーバFTP処理 *****************************"                >> $TS_LOGFILE

    echo "BCZY0020.sh go GXC"                                                                   >> $TS_LOGFILE
    BCZY0020.sh "go" "GXC"                                                                      >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    TS_BCZY0020_RCODE=${TS_STATUS}
    echo "BCZY0020 戻り値＝${TS_STATUS}"                                                        >> $TS_LOGFILE
    if [ "${TS_STATUS}" != "0" ];then
        TS_STEP_RCODE=${CNS_SYSTEMERR}
        TS_RCODE=1
    fi
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                   >> $TS_LOGFILE
fi

#-----------------------------------------------------------------------------------------
# ステップ-0220 GX伝送結果更新処理起動
#-----------------------------------------------------------------------------------------

if [ ${TS_STEP_RCODE} -lt ${CNS_GYOUMUERR_MAINSTOP} ];then
    TS_STEPID=0220
    BCZC1100.sh ${TS_STEPID}                                                                    >> $TS_LOGFILE
    echo "*********************************************************************"                >> $TS_LOGFILE
    echo "******************* GX伝送結果更新処理起動 **************************"                >> $TS_LOGFILE

    TS_STEP_RCODE=0
    #引数１：利用会社コード（STEP1取得）
    #引数２：処理実行日（STEP1取得）
    #引数３：起動ID（STEP1取得）
    #引数４：業務タスクID（STEP1取得）
    #引数５：連番（?）　　　　　　　　
    echo "MCZY7330 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_EXEC_ID_SH} \
                   ${CNS_NO_ID_8} "                                                             >> $TS_LOGFILE

    MCZY7330 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_KIDO_ID_SH} ${TS_EXEC_ID_SH} \
             ${CNS_NO_ID_8}                                                                     >> $TS_LOGFILE  2>&1
    TS_STATUS=$?
    echo "MCZY7330 戻り値＝${TS_STATUS}"                                                        >> $TS_LOGFILE
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
## ステップ-0230 実行状況管理UPDメイン
##-----------------------------------------------------------------------------------------
if [ ${TS_STATUS_20} == ${CNS_NORMAL} ];then
    TS_STEPID=0230
    BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
    echo "*********************************************************************"                    >> $TS_LOGFILE
    echo "********************実行状況管理UPDメイン****************************"                    >> $TS_LOGFILE
    
    #引数１：利用会社コード（STEP1取得）
    #引数２：処理実行日（STEP1取得）
    #引数３：起動ID（STEP1取得）
    #引数４：セッション区分（2：終了セッション）
    #引数５：アップロード総件数（0）　　　　　　　　
    #引数６：アップロードエラー件数（0）
    #引数７：DLファイル出力区分     　◇BCZY0020がコールされるの場合、
    #　　　　　　　　　　　　　　　　　　◇BCZY0020のRTNCD≠0の場合、
    #　　　　　　　　　　　　　　　　　　　　・BCZY0020の戻り値をセットする                                　　　　　　　　　　　　　　　　　　
    #                             　　　 ◇上記以外の場合（BCZY0020のRTNCD＝0）の場合、　
    #　　　　　　　　　　　　　　　　　　　　・△をセットする　　
    #　　　　　　　　　　　　　　　　 ◇上記以外（BCZY0020がコールされない）の場合、
    #　　　　　　　　　　　　　　　　　　・△をセットする　
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
    echo "MCZY7070 戻り値＝${TS_STATUS}"                                                            >> $TS_LOGFILE
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
# 処理終了
#-----------------------------------------------------------------------------------------
BCZC9999.sh ${TS_RCODE}                                                                         >> $TS_LOGFILE
exit 0
