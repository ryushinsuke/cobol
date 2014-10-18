      ******************************************************************
      *
      *  システムＩＤ   : T-STAR
      *  システム名称   : 次期TSTARシステム
      *  コピー句ＩＤ   : SCZY1020.cpy
      *  コピー句名称   : カレンダールーチンコピー句
      *
      *  改訂履歴
      *  年月日     所属       担当者  内容
      *  ---------- ---------- ------  ----------------------------
      *  20070926   SCS        厳偉偉   新規
      *
      ******************************************************************

         05  PARM-SCZY1020-ARG1.                                       
      *---------- 機能区分
             10  IXCAL-FUNCTION         PIC  X(01).
      *---------- 基準年月日１
             10  IXCAL-KJN-YMD1.
                 15  IXCAL-YY-1         PIC  9(04).
                 15  IXCAL-MM-1         PIC  9(02).
                 15  IXCAL-DD-1         PIC  9(02).
             10  IXCAL-KJN-YMD-1  REDEFINES  IXCAL-KJN-YMD1
                                        PIC  9(08).
      *---------- 計算ベース区分
             10  IXCAL-COMP-BASE        PIC  X(01).
      *---------- 前後区分１
             10  IXCAL-ZENGO-KBN-1      PIC  X(01).
      *---------- 前後区分２
             10  IXCAL-ZENGO-KBN-2      PIC  X(01).
      *---------- 単位区分
             10  IXCAL-TANI-KBN         PIC  X(01).
      *---------- 日数
             10  IXCAL-COMP-DAYS.
                 15  IXCAL-DAYS         PIC  S9(05)V9(06) COMP-3.
      *---------- 基準年月日２
             10  IXCAL-KJN-YMD2.
                 15  IXCAL-YY-2         PIC  9(04).
                 15  IXCAL-MM-2         PIC  9(02).
                 15  IXCAL-DD-2         PIC  9(02).
             10  IXCAL-KJN-YMD-2  REDEFINES  IXCAL-KJN-YMD2
                                        PIC  9(08).
      *---------- 基準日２－曜日
             10  IXCAL-KJN-2-YOBI       PIC  S9(02) COMP-3.
      *---------- 算出日付営業日暦日区分
         05  PARM-SCZY1020-ARG2.                                       
             10  IXCAL-HIZUKE-KBN       PIC  X(04).
                