#! /bin/sh
#-----------------------------------------------------------------------------------------
# システムＩＤ      ：  TSTAR
# システム名称      ：
# モジュールＩＤ    ：  BDYJ2001
# モジュール名称    ：  エラー検知処理
# 処理概要          ：  エラー検知処理
# 引数              ：  ARG1: go
# リターンコード    ：  0：正常終了
#                       1：異常終了
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  --------------------------------------
# 20121211  新規    GUT
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
# ローカル変数設定
#-----------------------------------------------------------------------------------------
#利用会社コード
TS_RIYO_CMPCD=`echo ${SJ_PEX_FRAME}|awk '{print substr($1,5,4)}'`
#メインログファイル
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log

#シェルのリターンコード
TS_RCODE=0

#-----------------------------------------------------------------------------------------
#エラー検知処理 START
#-----------------------------------------------------------------------------------------
BCZC0001.sh                                       >> ${TS_LOGFILE}
BCZC0000.sh                                       >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
# 引数確認
#-----------------------------------------------------------------------------------------
if [ "$1" != "go" ];then
    echo "Argument Error"                         >> ${TS_LOGFILE}
    TS_RCODE=1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
#-----------------------------------------------------------------------------------------
#ステップ-0010 MCZY7070 実行状況管理UPDメイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#MCZY7070 実行状況管理UPDメイン
MCZY7070 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} 1   >> ${TS_LOGFILE} 2>&1

#ステップ終了処理
TS_STATUS=$?
TS_STEP_RCODE=${TS_STATUS}                        >> ${TS_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
#-----------------------------------------------------------------------------------------
#ステップ-0020 MDYJ2001 エラー検知処理
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#MDYJ2001 エラー検知処理
MDYJ2001 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID}     >> ${TS_LOGFILE} 2>&1

#ステップ終了処理
TS_STATUS=$?
TS_STEPRCD=${TS_STATUS}
echo "TS_STEPRCD=" ${TS_STEPRCD}                  >> ${TS_LOGFILE}
TS_STEP_RCODE=${TS_STATUS}                        >> ${TS_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}
#-----------------------------------------------------------------------------------------
#ステップ-0030 MCZY7070 実行状況管理UPDメイン
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#MCZY7070 実行状況管理UPDメイン
MCZY7070 ${TS_RIYO_CMPCD} ${SJ_PEX_DATE} ${TS_KIDOID} 2   >> ${TS_LOGFILE} 2>&1

#ステップ終了処理
TS_STATUS=$?
TS_STEP_RCODE=${TS_STATUS}                        >> ${TS_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" -o "${TS_STEPRCD}" = "16" ];then
    echo "NG"                                     >> ${TS_LOGFILE}
    TS_RCODE=1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi
echo "OK"                                         >> ${TS_LOGFILE}
BCZC9999.sh ${TS_RCODE}                           >> ${TS_LOGFILE}
exit ${TS_RCODE}
