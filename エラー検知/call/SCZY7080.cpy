      ******************************************************************
      *
      *  システムＩＤ   : T-STAR
      *  システム名称   : 次期TSTARシステム
      *  コピー句ＩＤ   : SCZY7080.cpy
      *  コピー句名称   : ポートフォリオ別メッセージＩＮＳルーチン
      *
      *  改訂履歴
      *  年月日     区分  所属       担当者  内容
      *  ---------- ----  ---------- ------  ---------------------------
      *  20070827   新規  SCS        銭曉鳴  新規
      *
      ******************************************************************
      *---------- アーギュメントIN-1
             05  PARM-SCZY7080-ARG1.
      *---------- 利用会社コード
               10  RIYO-CMP-CD               PIC  X(04).
      *---------- 処理実行日
               10  SYORI-YMD                 PIC  X(08).
      *---------- 起動ID
               10  KIDOU-ID                  PIC  X(04).
      *---------- 業務タスクID
               10  GYOMU-TASK-ID             PIC  X(07).
      *---------- アーギュメントIN-2
             05  PARM-SCZY7080-ARG2.
      *---------- メッセージエリア
               10  MSG-AREA.
                 15  MESSAGE-AREA  OCCURS 999.
      *---------- ファンドコード
                   20  FUND-CD               PIC  X(12).
      *---------- ポートフォリオコード
                   20  PTF-CD                PIC  X(04).
      *---------- 評価系列コード
                   20  HYK-KRTU-CD           PIC  X(04).
      *---------- 帳票ID
                   20  REP-ID                PIC  X(08).
      *---------- 帳票任意コード
                   20  REP-ANY-CD            PIC  X(50).
      *---------- 基準日From
                   20  KJN-YMD-FROM          PIC  X(08).
      *---------- 基準日To
                   20  KJN-YMD-TO            PIC  X(08).
      *---------- メッセージID
                   20  MSG-ID                PIC  X(07).
      *---------- 置換文字
                   20  TIKAN-MOJI.
                     25 TK-MOJI  OCCURS  5   PIC  X(30).
      *---------- フリーメッセージ
                   20  FREE-MSG              PIC  X(200).
