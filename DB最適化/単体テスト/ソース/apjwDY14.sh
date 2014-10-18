#! /bin/sh
#-----------------------------------------------------------------------------------------
# システムＩＤ      ：  TSTAR
# システム名称      ：  次期TSTARシステム
# モジュールＩＤ    ：  apjwDY14
# モジュール名称    ：  DBサーバ領域の最適化処理
# 処理概要          ：  DBサーバ領域の最適化処理
# 引数              ：  ARG1: go
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  --------------------------------------
# 20090306  新規    SCS
# 20090605  更新    SCS     INMPORTした後、DUMPファイルを削除する
# 20091029  更新    SCS     INMPORTのオプションにBUFFER=80000を追加する
# 20130226  更新    GUT     テーマ3262-1:ＤＢサーバ領域の最適化処理復活
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# ローカル変数設定
#-----------------------------------------------------------------------------------------
#利用会社コード
TS_RIYO_CMPCD=`echo ${SJ_PEX_FRAME}|awk '{print substr($1,5,4)}'`
#バッチログファイル
TS_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log

#シェルのリターンコード
TS_RCODE=0

#-----------------------------------------------------------------------------------------
#DBサーバ領域の最適化処理 START
#-----------------------------------------------------------------------------------------
BCZC0001.sh
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
# ステップ-0010 最適化停止ファイルの存在チェック
#-----------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#最適化停止ファイル
TS_STOPFILE=${NAS_APL_DIR}/C000/stop/OPTTABLE_STOP_FILE.TXT

if [ -f ${TS_STOPFILE} ]; then
    echo "最適化停止ファイルの設置により処理をスキップしました"         >> ${TS_LOGFILE}
    TS_STEP_RCODE=0
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}     >> ${TS_LOGFILE}
    TS_RCODE=0
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

TS_STEP_RCODE=0
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

#-----------------------------------------------------------------------------------------
# ステップ-0020 最適化管理明細テーブル更新処理
#-----------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#基準日
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1403最適化管理明細テーブル更新処理
MDYB1403 ${TS_KJN_YMD}                            >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDBサーバ領域の最適化処理[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#ステップ-0030 MDYB1401最適化対象ファイル作成処理
#-----------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#最適化MAX容量
let TS_MAX_YOURYOU=${BL_OPT_MAX}*1024
#基準日
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1401最適化対象ファイル作成処理
MDYB1401  ${TS_MAX_YOURYOU} ${TS_KJN_YMD}        >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}        >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDBサーバ領域の最適化処理[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                      >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#ステップ-0040 DBサーバ領域の最適化処理
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
      
#最適化停止ファイルの存在チェック
      if [ -f ${TS_STOPFILE} ]; then
        echo "最適化停止ファイルの設置により処理を中断しました"         >> ${TS_LOGFILE}
        sed -i "${TS_TBL_COUNT},\$d" ${TS_TBL_FILE}                     >> ${TS_LOGFILE}
        TS_STATUS=0
        break
      fi
      
#最適化対象ファイルにテーブルの最適化開始日時を更新する。
      sed -i "${TS_TBL_COUNT}s/00000000000000/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}

#テーブルID パーティション名 MOVE 開始 日付時刻
      echo ${TS_TBL_ID} ${TS_PAR_NAME} MOVE 開始 `date '+%Y%m%d%H%M%S'`                    >> ${TS_LOGFILE}

#テーブルをMOVE
      if [ -z ${TS_PAR_NAME} ];then
        TS_MVSQL="ALTER TABLE ${TS_TBL_ID} MOVE;"
      else
        TS_MVSQL="ALTER TABLE ${TS_TBL_ID} MOVE PARTITION ${TS_PAR_NAME};"
      fi
      sqlplus -s ${TS_ORACLE} <<SQLEND                                  >> ${TS_LOGFILE}
      ${TS_MVSQL}
      EXIT;
SQLEND

#テーブルID パーティション名 MOVE 終了 日付時刻
      echo ${TS_TBL_ID} ${TS_PAR_NAME} MOVE 終了 `date '+%Y%m%d%H%M%S'`                    >> ${TS_LOGFILE}

#最適化対象ファイルにテーブルの最適化終了日時を更新する。
      sed -i "${TS_TBL_COUNT}s/99999999999999/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}

#テーブルID EXPORT 開始 日付時刻
#     echo ${TS_TBL_ID} EXPORT 開始 `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#テーブルをEXPORT
#      exp ${TS_ORACLE} FILE=${TS_DMP_FILE} TABLES=${TS_TBL_ID}   >> ${TS_LOGFILE} 2>&1
#
#
#EXPORTエラー判定
#     grep 'EXP-' ${TS_LOGFILE}
#     TS_STATUS=$?
#     if [ "$TS_STATUS" = "0" ];then
#         TS_STATUS=16
#         break
#     else
#         TS_STATUS=0
#     fi
#
#テーブルID EXPORT 終了 日付時刻
#     echo ${TS_TBL_ID} EXPORT 終了 `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#テーブルID TRUNCATE 開始 日付時刻
#     echo ${TS_TBL_ID} TRUNCATE 開始 `date '+%Y%m%d%H%M%S'`    >> ${TS_LOGFILE}
#
#TRUNCATE table テーブルID
#sqlplus -s ${TS_ORACLE} <<SQLEND                            >> ${TS_LOGFILE}
#TRUNCATE TABLE ${TS_TBL_ID};
#EXIT;
#SQLEND
#
#テーブルID TRUNCATE 終了 日付時刻
#     echo ${TS_TBL_ID} TRUNCATE 終了 `date '+%Y%m%d%H%M%S'`    >> ${TS_LOGFILE}
#
#テーブルID IMPORT 開始 日付時刻
#     echo ${TS_TBL_ID} IMPORT 開始 `date '+%Y%m%d%H%M%S'`  >> ${TS_LOGFILE}
#
#テーブルをIMPORT
#     imp ${TS_ORACLE} ignore=y FILE=${TS_DMP_FILE} TABLES=${TS_TBL_ID} BUFFER=80000       >> ${TS_LOGFILE} 2>&1
#
#IMPORTエラー判定
#     grep 'IMP-' ${TS_LOGFILE}
#     TS_STATUS=$?
#     if [ "$TS_STATUS" = "0" ];then
#         TS_STATUS=16
#         break
#     else
#         TS_STATUS=0
#     fi
#
#テーブルID IMPORT 終了 日付時刻
#     echo ${TS_TBL_ID} IMPORT 終了 `date '+%Y%m%d%H%M%S'`   >> ${TS_LOGFILE}
#
#最適化対象ファイルにテーブルの最適化開始日時を更新する。
#      sed -i "${TS_TBL_COUNT}s/99999999999999/`date '+%Y%m%d%H%M%S'`/g" ${TS_TBL_FILE}     >> ${TS_LOGFILE}
#
#DUMPファイルを削除する。
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
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDBサーバ領域の最適化処理[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#ステップ-0050 MDYB1402最適化結果更新処理
#-----------------------------------------------------------------------------------------
TS_STEPID=0050
BCZC1100.sh ${TS_STEPID}                          >> ${TS_LOGFILE}

#基準日
TS_KJN_YMD=${SJ_PEX_DATE}

#MDYB1402最適化結果更新処理
MDYB1402   ${TS_KJN_YMD}                          >> ${TS_LOGFILE} 2>&1

TS_STATUS=$?

TS_STEP_RCODE=${TS_STATUS}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}         >> ${TS_LOGFILE}

if [ "${TS_STATUS}" != "0" ];then
    TS_RCODE=1
    sjANM_sendmsg -cTBAP001 -n${SJ_PEX_JOB} -lE -mDBサーバ領域の最適化処理[step:${TS_STEPID}][rcode:${TS_RCODE}][${TS_LOGFILE}]  >> ${TS_LOGFILE} 2>&1
    BCZC9999.sh ${TS_RCODE}                       >> ${TS_LOGFILE}
    exit ${TS_RCODE}
fi

#-----------------------------------------------------------------------------------------
#DBサーバ領域の最適化処理 END
#-----------------------------------------------------------------------------------------
TS_RCODE=0
BCZC9999.sh ${TS_RCODE}                           >> ${TS_LOGFILE}
exit ${TS_RCODE}
