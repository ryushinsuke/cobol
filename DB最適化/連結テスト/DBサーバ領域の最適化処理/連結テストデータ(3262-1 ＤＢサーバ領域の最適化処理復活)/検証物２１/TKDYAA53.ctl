------------------------------------------------------------------------
--     システムＩＤ   : T-STAR
--     システム名称   : 新有価証券バックオフィスシステム
--
--     ＳＱＬＩＤ     : TKDYAA53
--     ＳＱＬ名称     : 「最適化管理テーブル」SQL*Loader制御ファイル
--
--     改訂履歴
--     年月日       所属       担当者  内容
--     ---------- ---------- ------  ----------------------------
--     2013/02/21   NRI                新規

LOAD DATA
INFILE "/home/apl01/BL/mdat/TKDYAA53.dat"
APPEND
INTO TABLE TKDYAA53
FIELDS TERMINATED BY "	"
        (TBL_ID                                            CHAR "NVL(:TBL_ID,' ')"                                               ,
         PRIO                                              INTEGER EXTERNAL "NVL(:PRIO,0)"                                       ,
         TABLE_KBN                                         CHAR "NVL(:TABLE_KBN,' ')"                                            ,
         UPD_DATE                                          DATE "YYYY/MM/DD HH24:MI:SS" "NVL(:UPD_DATE,'20070101000000')"        ,
         UPD_LOGIN_CMP_CD                                  CHAR "NVL(:UPD_LOGIN_CMP_CD,' ')"                                     ,
         UPD_SID                                           CHAR "NVL(:UPD_SID,' ')"                                              ,
         UPD_PGMID                                         CHAR "NVL(:UPD_PGMID,' ')"                                            )
