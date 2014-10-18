#! /bin/sh
#-------------------------------------------------------------------------------------------------------------
# システムＩＤ      ：  TSTAR
# システム名称      ：  次期TSTARシステム
# モジュールＩＤ    ：  apjxUB89
# モジュール名称    ：  夜間バッチシステム作成
# 処理概要          ：  夜間被災時の夜間バッチシステム作成
# 引数              ：  ARG1: go   ARG2: 実行基準日(yyyymmdd)
# リターンコード    ：  0：正常終了
#                       1：異常終了
#
# 改訂履歴
# 年月日    区分    所属    内容
# --------  ----    ------  ----------------------------------------------------------------------------------
# 20110105  新規    ASK     新規作成
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-------------------------------------------------------------------------------------------------------------
# 環境変数設定
#-------------------------------------------------------------------------------------------------------------
#実行基準日
SJ_PEX_DATE=$2
export SJ_PEX_DATE

#実行フレーム名
SJ_PEX_FRAME=apfxC000_xxxRX
export SJ_PEX_FRAME

#実行ジョブ名
SJ_PEX_JOB=apjxC000UB89
export SJ_PEX_JOB

#-------------------------------------------------------------------------------------------------------------
# ローカル変数設定
#-------------------------------------------------------------------------------------------------------------
#利用会社コード
TS_RIYO_CMPCD=`echo ${SJ_PEX_FRAME}|awk '{print substr($1,5,4)}'`

#バッチログファイル
DR_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log

#ジョブSKIPコマンドファイル
DR_SKIPFILE=${NAS_APL_DIR}/4999/work/DR_SKIP.lst

#GENチェック結果出力ディレクトリ
DR_GEN_CHECK_DIR=${NAS_APL_DIR}/4999/work

#シェルのリターンコード
TS_RCODE=0

#ジョブSKIPコマンド
DR_SKIPCMD=""

#シェルサーバー
#DR_SHL_SERVER="tduk0047"        #運用監視サーバー（本番）
DR_SHL_SERVER="RLSJV076"        #運用監視サーバー（クラウド環境）

#処理判断（アプリ）
DR_EXEC_APL=0

#処理判断（祝日）
DR_EXEC_HOLI=0

#処理判断（土曜日）
DR_EXEC_SAT=0

#処理判断ステータス
DR_EXEC_STATUS=0

#-------------------------------------------------------------------------------------------------------------
# 初期処理
#-------------------------------------------------------------------------------------------------------------
BCZC0001.sh                                                                                                                 >> ${DR_LOGFILE}
BCZC0000.sh                                                                                                                 >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# 引数確認
#-------------------------------------------------------------------------------------------------------------
#第一引数が'go'ではない場合「Argument Error」を表示し、ジョブ異常終了。
if [ "$1" != "go" ];then
    echo "Argument Error"                                                                                                   >> ${DR_LOGFILE}
    TS_RCODE=1
    echo "リターンコード="${TS_RCODE}                                                                                       >> ${DR_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                                                                                                 >> ${DR_LOGFILE}
    exit ${TS_RCODE}
fi

#第二引数が設定されていない場合「運用日付未指定」を表示し、ジョブ異常終了。
if [ "${SJ_PEX_DATE}" = "" ];then
    echo "運用日付未指定"                                                                                                   >> ${DR_LOGFILE}
    TS_RCODE=1
    echo "リターンコード="${TS_RCODE}                                                                                       >> ${DR_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                                                                                                 >> ${DR_LOGFILE}
    exit ${TS_RCODE}
else
    echo "実行基準日 ＝ " ${SJ_PEX_DATE}                                                                                    >> ${DR_LOGFILE}
fi

#-------------------------------------------------------------------------------------------------------------
# ステップ-0010 顧問夜間バッチジェネレート処理
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

#スケジュール登録「実行システムの作成」（th_RXAPLBT1）
echo "システム[th_RXAPLBT1]作成開始・・・"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT1 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "システム[th_RXAPLBT1]は一部もしくは全てのフレームが非運用日のため登録されないフレームが存在するか、システム作成を行いません"      >> ${DR_LOGFILE}
    else
        echo "システム[th_RXAPLBT1]作成エラー"                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "システム[th_RXAPLBT1]作成完了"                                                                                    >> ${DR_LOGFILE}
fi

#スケジュール登録「実行システムの作成」（th_RXAPLBT2）
echo "システム[th_RXAPLBT2]作成開始・・・"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT2 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "システム[th_RXAPLBT2]は一部もしくは全てのフレームが非運用日のため登録されないフレームが存在するか、システム作成を行いません"      >> ${DR_LOGFILE}
    else
        echo "システム[th_RXAPLBT2]作成エラー"                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "システム[th_RXAPLBT2]作成完了"                                                                                    >> ${DR_LOGFILE}
fi

#スケジュール登録「実行システムの作成」（th_RXAPLBT3）
echo "システム[th_RXAPLBT3]作成開始・・・"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT3 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "システム[th_RXAPLBT3]は一部もしくは全てのフレームが非運用日のため登録されないフレームが存在するか、システム作成を行いません"      >> ${DR_LOGFILE}
    else
        echo "システム[th_RXAPLBT3]作成エラー"                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "システム[th_RXAPLBT3]作成完了"                                                                                    >> ${DR_LOGFILE}
fi

#スケジュール登録「実行システムの作成」（th_RX祝日BT）
echo "システム[th_RX祝日BT]作成開始・・・"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RX祝日BT -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "システム[th_RX祝日BT]は一部もしくは全てのフレームが非運用日のため登録されないフレームが存在するか、システム作成を行いません"      >> ${DR_LOGFILE}
    else
        echo "システム[th_RX祝日BT]作成エラー"                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_HOLI=1
    fi
else
    echo "システム[th_RX祝日BT]作成完了"                                                                                    >> ${DR_LOGFILE}
fi

#スケジュール登録「実行システムの作成」（th_RX土曜日BT）
echo "システム[th_RX土曜日BT]作成開始・・・"                                                                                >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RX土曜日BT -d${SJ_PEX_DATE}                                                      >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "システム[th_RX土曜日BT]は一部もしくは全てのフレームが非運用日のため登録されないフレームが存在するか、システム作成を行いません"    >> ${DR_LOGFILE}
    else
        echo "システム[th_RX土曜日BT]作成エラー"                                                                            >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_SAT=1
    fi
else
    echo "システム[th_RX土曜日BT]作成完了"                                                                                    >> ${DR_LOGFILE}
fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# ステップ-0020 顧問夜間バッチジェネレートチェック処理
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

if [ "${DR_EXEC_APL}" = "0" ]; then

    #実行システム作成検査(th_RXAPLBT1)
    echo "システム[th_RXAPLBT1]GENチェック・・・"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT1 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "システム[th_RXAPLBT1]は非運用日のためフレーム投入は行いません"                                            >> ${DR_LOGFILE}
        else
            echo "システム[th_RXAPLBT1]ジェネレートチェックエラー"                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "システム[th_RXAPLBT1]は投入対象です"                                                                          >> ${DR_LOGFILE}
    fi

    #実行システム作成検査(th_RXAPLBT2)
    echo "システム[th_RXAPLBT2]GENチェック・・・"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT2 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "システム[th_RXAPLBT2]は非運用日のためフレーム投入は行いません"                                            >> ${DR_LOGFILE}
        else
            echo "システム[th_RXAPLBT2]ジェネレートチェックエラー"                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "システム[th_RXAPLBT2]は投入対象です"                                                                          >> ${DR_LOGFILE}
    fi

    #実行システム作成検査(th_RXAPLBT3)
    echo "システム[th_RXAPLBT3]GENチェック・・・"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT3 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "システム[th_RXAPLBT3]は非運用日のためフレーム投入は行いません"                                            >> ${DR_LOGFILE}
        else
            echo "システム[th_RXAPLBT3]ジェネレートチェックエラー"                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "システム[th_RXAPLBT3]は投入対象です"                                                                          >> ${DR_LOGFILE}
    fi
fi

if [ "${DR_EXEC_HOLI}" = "0" ]; then

    #実行システム作成検査(th_RX祝日BT)
    echo "システム[th_RX祝日BT]GENチェック・・・"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RX祝日BT -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "システム[th_RX祝日BT]は非運用日のためフレーム投入は行いません"                                            >> ${DR_LOGFILE}
        else
            echo "システム[th_RX祝日BT]ジェネレートチェックエラー"                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_HOLI=1
        fi
    else
        echo "システム[th_RX祝日BT]は投入対象です"                                                                          >> ${DR_LOGFILE}
    fi
fi

if [ "${DR_EXEC_SAT}" = "0" ]; then

    #実行システム作成検査(th_RX土曜日BT)
    echo "システム[th_RX土曜日BT]GENチェック・・・"                                                                         >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RX土曜日BT -pa2 -dir${DR_GEN_CHECK_DIR}                   >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "システム[th_RX土曜日BT]は非運用日のためフレーム投入は行いません"                                          >> ${DR_LOGFILE}
        else
            echo "システム[th_RX土曜日BT]ジェネレートチェックエラー"                                                        >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
        fi
    else
        echo "システム[th_RX土曜日BT]は投入対象です"                                                                        >> ${DR_LOGFILE}
    fi
fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# ステップ-0030 ディフォルトSKIP設定処理
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

if [ "${DR_EXEC_APL}" = "0" ]; then

    #「apfdC000_200RX」が出力されているか検査
    grep -l "apfdC000_200RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #ネットと後続ジョブを連続でスキップに設定（apfdC000_200RX:apndC000DY20～）(オンライン停止～)
        echo "apfdC000_200RX - apndC000DY20～後続SKIP指定・・・"                                                            >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -n -d${SJ_PEX_DATE} -FapfdC000_200RX -NapndC000DY20                           >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfdC000_200RXフレームapndC000DY20のNETSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi

        #ネットを単独でスキップに設定（apfdC000_200RX:apndC000DY23）(拠点印刷監視プロセス停止)
        echo "apfdC000_200RX - apndC000DY23：拠点印刷監視プロセス停止処理SKIP指定・・・"                                    >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -FapfdC000_200RX -NapndC000DY23                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfdC000_200RXフレームapndC000DY23のNETSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi
    fi

    #「apfd1000_100RX」が出力されているか検査
    grep -l "apfd1000_100RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #ネットを単独でスキップに設定（apfd1000_100RX:apndC000JC10）(ＧＤＢ接続)
        echo "apfd1000_100RX - apndC000JC10:ＧＤＢ接続処理SKIP指定・・・"                                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -Fapfd1000_100RX -NapndC000JC10                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfd1000_100RXフレームのNETSKIP設定エラー"                                                                >> ${DR_LOGFILE}
        fi
    fi

    #「apfduuuu_100RX」ＡＰＬ業務バッチ(会社別)フレームが出力されているか検査
    echo "平日会社別フレームのデフォルトSKIP指定処理開始・・・"                                                             >> ${DR_LOGFILE}
    for TS_USER_CD in `cat ${APL_DATEFILE_DIR}/USCOM_KIBO_L_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_M_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_S_RX.dat |grep -v '4999'`
    do
        echo "会社規模ファイルから取得した会社コード："${TS_USER_CD}                                                        >> ${DR_LOGFILE}
        grep -l "apfd"${TS_USER_CD}"_100RX" ${DR_GEN_CHECK_DIR}/*.txt                                                       >> ${DR_LOGFILE}
        if [ "$?" = "0" ];then

            #ジョブを単独でスキップに設定（apfduuuu_100RX:apjdC000JC42）(直近保有銘柄リスト作成)
            echo "apfd"${TS_USER_CD}"_100RX - apndC000JC11 - apjdC000JC42:直近保有銘柄リスト作成処理SKIP指定・・・"         >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfd${TS_USER_CD}_100RX -NapndC000JC11 apjdC000JC42    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfd"${TS_USER_CD}"_100RXフレームapjdC000JC42のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi

            #ジョブを単独でスキップに設定（apfduuuu_100RX:apjdC000JC43）(直近保有銘柄リストＦＴＰ)
            echo "apfd"${TS_USER_CD}"_100RX - apndC000JC12 - apjdC000JC43:直近保有銘柄リストFTP処理SKIP指定・・・"          >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfd${TS_USER_CD}_100RX -NapndC000JC12 apjdC000JC43    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfd"${TS_USER_CD}"_100RXフレームapjdC000JC43のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi
        else
            echo "平日会社別フレームapfd"${TS_USER_CD}"_100RXは投入対象外"                                                  >> ${DR_LOGFILE}
        fi
    done

fi

if [ "${DR_EXEC_HOLI}" = "0" ]; then

    #「apfd1000_101RX」が出力されているか検査
    grep -l "apfd1000_101RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #ネットを単独でスキップに設定（apfd1000_101RX:apndC000JC10）(ＧＤＢ接続)
        echo "apfd1000_101RX - apndC000JC10:ＧＤＢ接続処理SKIP指定・・・"                                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -Fapfd1000_101RX -NapndC000JC10                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_HOLI=1
            echo "apfd1000_101RXフレームのNETSKIP設定エラー"                                                                >> ${DR_LOGFILE}
        fi
    fi
fi

if [ "${DR_EXEC_SAT}" = "0" ]; then

    #「apfwC000_20RXH」が出力されているか検査
    grep -l "apfwC000_20RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #ネットと後続ジョブを連続でスキップに設定（apfwC000_20RXH:apndC000DY20～）(オンライン停止～)
        echo "apfwC000_20RXH - apndC000DY20～後続SKIP指定・・・"                                                            >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -n -d${SJ_PEX_DATE} -FapfwC000_20RXH -NapndC000DY20                           >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_20RXHフレームapndC000DY20のNETSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi

        #ネットを単独でスキップに設定（apfwC000_20RXH:apndC000DY23）(拠点印刷監視プロセス停止)
        echo "apfwC000_20RXH - apndC000DY23：拠点印刷監視プロセス停止処理SKIP指定・・・"                                    >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -FapfwC000_20RXH -NapndC000DY23                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_20RXHフレームapndC000DY23のNETSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi
    fi

    #「apfwuuuu_10RXH」土曜日会社別フレームが出力されているか検査
    echo "土曜会社別フレームのデフォルトSKIP指定処理開始・・・"                                                             >> ${DR_LOGFILE}
    for TS_USER_CD in `cat ${APL_DATEFILE_DIR}/USCOM_KIBO_L_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_M_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_S_RX.dat |grep -v '4999'`
    do
        echo "会社規模ファイルから取得した会社コード："${TS_USER_CD}                                                        >> ${DR_LOGFILE}
        grep -l "apfw"${TS_USER_CD}"_10RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                       >> ${DR_LOGFILE}
        if [ "$?" = "0" ];then

            #ジョブを単独でスキップに設定（apfwuuuu_10RXH:apjmC000DY13）(進捗管理データ削除[会社別])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY13:進捗管理データ削除処理SKIP指定・・・"             >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY13    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXHフレームapjmC000DY13のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi

            #ジョブを単独でスキップに設定（apfwuuuu_10RXH:apjmC000DY54）(時価・為替バックアップ取得[会社別])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY54:時価・為替バックアップ取得処理SKIP指定・・・"     >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY54    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXHフレームapjmC000DY54のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi

            #ジョブを単独でスキップに設定（apfwuuuu_10RXH:apjmC000DY55）(時価・為替バックアップ配信[会社別])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY55:時価・為替バックアップ配信処理SKIP指定・・・"     >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY55    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXHフレームapjmC000DY55のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi

            #ジョブを単独でスキップに設定（apfwuuuu_10RXH:apjmC000DY50）(業務データ削除[会社別])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY50:業務データ削除処理SKIP指定・・・"                 >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY50    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXHフレームapjmC000DY50のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi

            #ジョブを単独でスキップに設定（apfwuuuu_10RXH:apjmC000DY17）(パーティション削除[会社別])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY17:パーティション削除処理SKIP指定・・・"             >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY17    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXHフレームapjmC000DY17のJOBSKIP設定エラー"                                     >> ${DR_LOGFILE}
            fi
        else
            echo "土曜会社別フレームapfw"${TS_USER_CD}"_10RXHは投入対象外"                                                  >> ${DR_LOGFILE}
        fi
    done

    #「apfwC000_21RXH」が出力されているか検査
    grep -l "apfwC000_21RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #ジョブを単独でスキップに設定（apfwC000_21RXH:apjmC000DY54）(時価・為替バックアップ取得[共通])
        echo "apfwC000_21RXH - apjmC000DY54:時価・為替バックアップ取得処理([共通])SKIP指定・・・"                           >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjmC000DY54               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXHフレームapjmC000DY54のJOBSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi

        #ジョブを単独でスキップに設定（apfwC000_21RXH:apjmC000DY50）(業務データ削除[共通])
        echo "apfwC000_21RXH - apjmC000DY50:業務データ削除処理([共通])SKIP指定・・・"                                       >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjmC000DY50               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXHフレームapjmC000DY50のJOBSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi

        #ジョブを単独でスキップに設定（apfwC000_21RXH:apjwC000DY14）(DBサーバ領域の最適化処理[共通])
        echo "apfwC000_21RXH - apjwC000DY14:DBサーバ領域の最適化処理[共通]SKIP指定・・・"                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjwC000DY14               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXHフレームapjwC000DY14のJOBSKIP設定エラー"                                                    >> ${DR_LOGFILE}
        fi
    fi

fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# ステップ-0040 個別SKIP設定処理
#-------------------------------------------------------------------------------------------------------------
if [ "${DR_EXEC_STATUS}" != "16" ]; then
    TS_STEPID=0040
    BCZC1100.sh ${TS_STEPID}                                                                                                >> ${DR_LOGFILE}

    #ジョブSKIPコマンドファイルが存在するかチェックする
    if [ -f ${DR_SKIPFILE} ]; then

        #ジョブSKIPコマンドファイルを１行ずつ読み込む
        while read DR_SKIPCMD
        do
            #取得したコマンドを発行
            ${DR_SKIPCMD}                                                                                                   >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                echo "JOBSKIP設定エラー "${DR_SKIPCMD}                                                                      >> ${DR_LOGFILE}
                DR_EXEC_STATUS=16
            fi

        done < ${DR_SKIPFILE}

    else
        echo "個別SKIP設定の必要があるジョブは存在しません"                                                                 >> ${DR_LOGFILE}
    fi

    TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                         >> ${DR_LOGFILE}
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                               >> ${DR_LOGFILE}
fi

#-------------------------------------------------------------------------------------------------------------
# 終了処理
#-------------------------------------------------------------------------------------------------------------
if [ "${DR_EXEC_STATUS}" = "0" ];then
    TS_RCODE=0
else
    TS_RCODE=1
fi

BCZC9999.sh ${TS_RCODE}                                                                                                     >> ${DR_LOGFILE}
exit ${TS_RCODE}
