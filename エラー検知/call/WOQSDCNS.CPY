      *
      * システムID    :  WOQ
      * システム名称  :  MQ支援システム
      * 内容          :	WOQSDCNSリクエストパケット定義ヘッダ
      *
      * 改訂履歴
      * 年月日   区分 所属　　 担当　　内容
      * -------- ---- -------- ------- --------------------------------
      * 19950928 新規 日本IBM 佐藤    新規
      *
      *
      * Copyright (C) 1995 by Nomura Research Institute,Ltd.
      * All rights reserved.
      *
      ** WOQCONS ARGMENT **
           10  CON-PGM-NAME   PIC X(16)   VALUE SPACE.
      *    * プログラム名称
           10  CON-MDL-RTN1   PIC S9(9)   USAGE IS COMP-5 VALUE ZERO.
      *    * リターンコード
           10  CON-MDL-RTN2   PIC S9(9)   USAGE IS COMP-5 VALUE ZERO.
      *    * 詳細コード
           10  FILLER         PIC X(16)   VALUE SPACE.
      *    * 予備
           10  CON-MSG-CODE   PIC X(7)    VALUE SPACE.
      *    * メッセージコード
           10  CON-GETQ-NAME  PIC X(16)   VALUE SPACE.
      *    * ＧＥＴキュー名
           10  FILLER         PIC X(9)    VALUE SPACE.
      *    * 予備
