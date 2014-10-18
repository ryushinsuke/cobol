#! /bin/sh
#-----------------------------------------------------------------------------------------
# サブシステムＩＤ  ：  銘柄別評価計算管理
# サブシステム名称  ：  次期TSTARシステム
# モジュールＩＤ    ：  BMHS0001
# モジュール名称    ：  銘柄別評価計算起動
# 処理概要          ：  銘柄別評価計算起動
# 引数              ：  ARG1    :　　
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  --------------------------------------
# 20070917  新規    SCS     顧孜駿 　新規作成
# 20091016  修正    SCS     顧孜駿   総合障害対応No.0003149
# 20110414  修正    SCS     余少林   テーマ3212-2
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
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

#シェルのリターンコード
TS_RCODE=0
#正常
CNS_NORMAL=0
#######    総合障害対応No.0003149 20091016 修正  開始    #########
#プログラムウォーニング
CNS_WARNING=2
#######    総合障害対応No.0003149 20091016 修正  終了    #########
#業務エラー(続行可)
CNS_GYOUMUERR_GO=4
#業務エラー(明細続行不可)
CNS_GYOUMUERR_MEISAISTOP=6
#業務エラー(処理中メイン続行不可)
CNS_GYOUMUERR_STOP=8
#######    総合障害対応No.0003149 20091016 修正  開始    #########
#プログラム業務エラー(続行不可能)
CNS_GYOUMUERR_STOP2=10
#######    総合障害対応No.0003149 20091016 修正  終了    #########
#システムエラー
CNS_SYSTEMERR=16
#シェルエラー
CNS_SHELLERR=90

#-----------------------------------------------------------------------------------------
# ステップ-0010 利用会社コード、処理実行日、起動ID、業務タスクID 取得
#-----------------------------------------------------------------------------------------
TS_STEPID=0010

TS_STEP_RCODE=0

#利用会社コード　←　環境変数TS_RIYO_CMPCD
if [ "${TS_RIYO_CMPCD}" != "" ];then
    TS_RIYOCMP_CD=`echo ${TS_RIYO_CMPCD}`
else
    TS_RCODE=1
    echo "利用会社コード取得失敗"
fi

#処理実行日　←　環境変数SJ_PEX_DATE
if [ "${SJ_PEX_DATE}" != "" ];then
    TS_PEX_DATE=`echo ${SJ_PEX_DATE}`
else
    TS_RCODE=1
    echo "処理実行日取得失敗"
fi

#起動ID　←　環境変数TS_KIDOID
if [ "${TS_KIDOID}" != "" ];then
    TS_KIDO_ID=`echo ${TS_KIDOID}`
else
    TS_RCODE=1
    echo "起動ID取得失敗"
fi

#業務タスクID　←　環境変数TS_EXECID
if [ "${TS_EXECID}" != "" ];then
    TS_EXEC_ID=`echo ${TS_EXECID}`
else
    TS_RCODE=1
    echo "業務タスクID取得失敗"
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
echo "*** 銘柄別評価計算起動 *** "                                                              >> $TS_LOGFILE

sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********利用会社コード、処理実行日、起動ID、業務タスクID取得*******"                    >> $TS_LOGFILE
echo "利用会社コード = ${TS_RIYOCMP_CD}"                                                        >> $TS_LOGFILE
echo "処理実行日     = ${TS_PEX_DATE}"                                                          >> $TS_LOGFILE
echo "起動ID         = ${TS_KIDO_ID}"                                                           >> $TS_LOGFILE
echo "業務タスクID     = ${TS_EXEC_ID}"                                                           >> $TS_LOGFILE
sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE

#-----------------------------------------------------------------------------------------
# ステップ-0020 実行状況管理UPDメイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********実行状況管理UPDメイン**************************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：セッション区分（１：先頭セッション）
#引数５：アップロード総件数（0）
#引数６：アップロードエラー件数（0）
#引数７：DLファイル出力区分（スペース)
echo "MCZY7070 ${TS_RIYOCMP_CD}    ${TS_PEX_DATE}   ${TS_KIDO_ID} \
               ${TS_SESSION_KBN_1} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"      >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} ${TS_SESSION_KBN_1} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                                 >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
    if [ "${TS_DNKBN}" = "N" ];then
        sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
    fi
fi

sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    sh BCZC9999.sh ${TS_RCODE}                                                                  >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# ステップ-0030 銘柄別評価計算起動
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "*************************銘柄別評価計算起動**************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：業務タスクID（STEP1取得）

echo "MMHJ0010 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}"                       >> $TS_LOGFILE

MMHJ0010 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} ${TS_EXECID}                              >> $TS_LOGFILE  2>&1
TS_STATUS=$?
echo "MMHJ0010 戻り値＝${TS_STATUS}"                                                            >> $TS_LOGFILE
case $TS_STATUS in
#正常
0)TS_STEP_RCODE=${CNS_NORMAL}
  echo "正常終了"                                                                               >> $TS_LOGFILE
;;
#######    総合障害対応No.0003149 20091016 修正  開始    #########
#プログラムウォーニング
2)TS_STEP_RCODE=${CNS_WARNING}
  echo "プログラムウォーニング"                                                                 >> $TS_LOGFILE
;;
#######    総合障害対応No.0003149 20091016 修正  終了    #########
#業務エラー(続行可)
4)TS_STEP_RCODE=${CNS_GYOUMUERR_GO}
  echo "業務エラー(続行可)終了"                                                                 >> $TS_LOGFILE
;;
#業務エラー(続行可)
6)TS_STEP_RCODE=${CNS_GYOUMUERR_MEISAISTOP}
  echo "業務エラー(明細続行不可)終了"                                                           >> $TS_LOGFILE
;;
#######    総合障害対応No.0003149 20091016 修正  開始    #########
#業務エラー(処理中メイン続行不可)
8)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP}
  echo "業務エラー(処理中メイン続行不可)終了"                                                   >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
#業務エラー(続行不可)
10)TS_STEP_RCODE=${CNS_GYOUMUERR_STOP2}
  echo "業務エラー(続行不可)終了"                                                               >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
#######    総合障害対応No.0003149 20091016 修正  終了    #########
#システムエラー
16)TS_RCODE=1
   TS_STEP_RCODE=${CNS_SYSTEMERR}
   echo "システムエラー終了"                                                                    >> $TS_LOGFILE
#  if [ "${TS_DNKBN}" = "N" ];then
#      sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
#  fi
;;
*)TS_RCODE=1
  TS_STEP_RCODE=${CNS_SYSTEMERR}
# if [ "${TS_DNKBN}" = "N" ];then
#     sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]       >> $TS_LOGFILE  2>&1
# fi
;;
esac
sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE

##-----------------------------------------------------------------------------------------
## ステップ-0040 実行状況管理UPDメイン
##-----------------------------------------------------------------------------------------
TS_STEPID=0040
sh BCZC1100.sh ${TS_STEPID}                                                                     >> $TS_LOGFILE
echo "*********************************************************************"                    >> $TS_LOGFILE
echo "**********実行状況管理UPDメイン**************************************"                    >> $TS_LOGFILE

TS_STEP_RCODE=0
#引数１：利用会社コード（STEP1取得）
#引数２：処理実行日（STEP1取得）
#引数３：起動ID（STEP1取得）
#引数４：セッション区分（2：終了セッション）
#引数５：アップロード総件数（0）　　　　　　　　
#引数６：アップロードエラー件数（0）
#引数７：DLファイル出力区分（スペース)
echo "MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} \
               ${TS_SESSION_KBN_2} ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}"                 >> $TS_LOGFILE

MCZY7070 ${TS_RIYOCMP_CD} ${TS_PEX_DATE} ${TS_KIDO_ID} ${TS_SESSION_KBN_2} \
         ${TS_UPLOAD_CNT} ${TS_UPLERR_CNT} ${TS_OUTFILE_KBN_B}                        >> $TS_LOGFILE  2>&1
TS_STATUS=$?
if [ "$TS_STATUS" != "0" ];then
    TS_RCODE=1
    TS_STEP_RCODE=${CNS_SYSTEMERR}
    if [ "${TS_DNKBN}" = "N" ];then
        sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mジョブが異常終了しました[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]      >> $TS_LOGFILE  2>&1
    fi
fi

sh BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                    >> $TS_LOGFILE
if [ ${TS_RCODE} != 0 ];then
    sh BCZC9999.sh ${TS_RCODE}                                                                  >> $TS_LOGFILE
    exit 1
fi

#-----------------------------------------------------------------------------------------
# 処理終了
#-----------------------------------------------------------------------------------------
sh BCZC9999.sh ${TS_RCODE}                                                                      >> $TS_LOGFILE
exit 0
