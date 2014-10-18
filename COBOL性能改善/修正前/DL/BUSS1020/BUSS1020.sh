#! /bin/sh
#-----------------------------------------------------------------------------------------
# サブシステムＩＤ  ：  運用成果残高データ保存
# サブシステム名称  ：  次期TSTARシステム
# モジュールＩＤ    ：  BUSS1020
# モジュール名称    ：  運用成果残高データ保存
# 処理概要          ：  運用成果残高データ保存
# 引数              ：  ARG1    :　　
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  --------------------------------------
# 20080903  新規    SCS     徐勝飛 　新規作成
# 20090409  修正    SCS     劉新文   残タスク194対応
# 20130709  修正    SCS     潘遠     テーマ3545-1
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
#シェルのリターンコード
TS_RCODE=0
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
echo "*** 運用成果残高データ保存起動 *** "                                                      >> $TS_LOGFILE


BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********利用会社コード、処理実行日、起動ID、業務タスクID取得*******"                    >> $TS_LOGFILE
echo "利用会社コード = ${TS_RIYOCMP_CD_SH}"                                                        >> $TS_LOGFILE
echo "処理実行日     = ${TS_PEX_DATE_SH}"                                                          >> $TS_LOGFILE
echo "起動ID         = ${TS_KIDO_ID_SH}"                                                           >> $TS_LOGFILE
echo "業務タスクID     = ${TS_EXEC_ID_SH}"                                                         >> $TS_LOGFILE
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE


#-----------------------------------------------------------------------------------------
# ステップ-0020 実行状況管理UPDメイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************実行状況管理UPDメイン****************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：セッション区分（１：先頭セッション）
#引数５：アップロード総件数（0）
#引数６：アップロードエラー件数（0）
#引数７：DLファイル出力区分（スペース)
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
# ステップ-0030 運用成果残高データ保存
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************運用成果残高データ保存***********************"                        >> $TS_LOGFILE

TS_STEP_RCODE=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：業務タスクID（STEP1取得）
#引数４：起動ID（STEP1取得）

echo "MUSJ0251 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}"                       >> $TS_LOGFILE

MUSJ0251 ${TS_RIYOCMP_CD_SH} ${TS_PEX_DATE_SH} ${TS_EXEC_ID_SH} ${TS_KIDO_ID_SH}                              >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo "MUSJ0251 戻り値＝${TS_STATUS}"                                                            >> $TS_LOGFILE
case $TS_STATUS in
#正常
0)TS_STEP_RCODE=${CNS_NORMAL}
  echo "正常終了"                                                                               >> $TS_LOGFILE
;;
#警告
2)TS_STEP_RCODE=${CNS_WARNING}
  echo "警告終了"                                                                               >> $TS_LOGFILE
;;
#業務エラー(続行可)
4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
  echo "業務エラー(続行可)終了"                                                                 >> $TS_LOGFILE
;;
#業務エラー（明細続行不可）
6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
  echo "業務エラー（明細続行不可）終了"                                                         >> $TS_LOGFILE
;;
#業務エラー（処理中メイン続行不可）
8)TS_STEP_RCODE=${CNS_GYOUMUERR_MAINSTOP}
  echo "業務エラー（処理中メイン続行不可）終了"                                                 >> $TS_LOGFILE
;;
#業務エラー(続行不可)
10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
  echo "業務エラー(続行不可)終了"                                                               >> $TS_LOGFILE
;;
#システムエラー
16)TS_RCODE=1
   TS_STEP_RCODE=${CNS_SYSTEMERR}
   echo "システムエラー終了"                                                                    >> $TS_LOGFILE
;;
*)TS_RCODE=1
  TS_STEP_RCODE=${CNS_SYSTEMERR}
;;
esac
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                       >> $TS_LOGFILE
fi

##-----------------------------------------------------------------------------------------
## ステップ-0040 実行状況管理UPDメイン
##-----------------------------------------------------------------------------------------
TS_STEPID=0040
BCZC1100.sh ${TS_STEPID}                                                                        >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "********************実行状況管理UPDメイン****************************"                    >> $TS_LOGFILE

#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：セッション区分（2：終了セッション）
#引数５：アップロード総件数（0）　　　　　　　　
#引数６：アップロードエラー件数（0）
#引数７：DLファイル出力区分     RTNCD≠16の場合に△、
#                               RTNCD=16の場合に9、
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
# 処理終了
#-----------------------------------------------------------------------------------------
BCZC9999.sh ${TS_RCODE}                                                                         >> $TS_LOGFILE
exit 0
