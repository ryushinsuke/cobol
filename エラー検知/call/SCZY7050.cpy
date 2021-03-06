      ******************************************************************
      *
      *  システムＩＤ   : T-STAR
      *  システム名称   : 次期TSTARシステム
      *  コピー句ＩＤ   : SCZY7050.cpy
      *  コピー句名称   : 実行状況管理明細ＩＮＳルーチンコピー句
      *
      *  改訂履歴
      *  年月日     所属       担当者  内容
      *  ---------- ---------- ------  ----------------------------
      *  20080330   SCS        沈焔　  新規
      *
      ******************************************************************

         05  PARM-SCZY7050-ARG1.
      *----------  利用会社コード
           10  RIYO-CMP-CD              PIC  X(04).
      *----------  処理実行日
           10  SYORI-YMD                PIC  9(08).
      *----------  起動ID
           10  KIDOU-ID                 PIC  X(04).
      *----------  業務タスクID
           10  GYOMU-TASK-ID            PIC  X(07).
      *----------  ファンドコード
           10  FUND-CD                  PIC  X(12).
      *----------  ポートフォリオコード
           10  PTF-CD                   PIC  X(04).
      *----------  評価系列コード
           10  HYK-KRTU-CD              PIC  X(04). 
      *----------  帳票ID
           10  REP-ID                   PIC  X(08). 
      *----------  任意コード
           10  REP-ANY-CD               PIC  X(50). 
      *----------  基準日FROM
           10  KJN-YMD-FROM             PIC  9(08). 
      *----------  基準日TO
           10  KJN-YMD-TO               PIC  9(08). 
