      *
      * システムID   :WOM
      * システム名称 :サーバ基盤ミドルソフト
      * プログラムID :WOMCMAIFA.CPY
      * 処理概要(目的,使用法,重要な変数など):
      *     ＡＩＦＡ定義ヘッダ
      *

      * 改訂履歴
      * 年月日   区分 所属　　 担当　　内容
      * -------- ---- -------- ------- --------------------------------
      * 19950406 新規 S銀13    鮫島    新規
      * 95.06.28 修正 S銀13    小柳    コーディング基準に準拠
      * 95.07.06 修正 S銀13    小柳    業務ランク変更 #PSD-201
      * 95.10.17 修正 S金13    木村    AIFA V0201支援 #PCL301
      * 95.10.17 修正 S金13    木村    TP1ｴﾗｰｺｰﾄﾞ支援 #PCL309
      * 96.02.20 修正 S金13    河原    VALUE句削除    #PSD333
      *

      *
      * Copyright (C) 1995 by Nomura Research Institute,Ltd.
      * All rights reserved.
      *
      ** WOMAIFA **
      ***  AIFA-ST.
           10  AIFA-SIZE           PIC  S9(4)
                                   USAGE IS COMP-5.
      *    * ＡＩＦＡサイズ
           10  VR-NO               PIC  X(4).
      *    * バージョン番号
           10  ON-LINE-DATE        PIC  X(8).
      *    * オンライン日付
           10  PROC-DATE           PIC  X(8).
      *    * 処理年月日
           10  APL-DATE            PIC  X(6).
      *    * ＡＰ起動時刻
           10  SV-HOST-NAME        PIC  X(32).
      *    * 自サーバ名称
           10  CLT-APL-NAME        PIC  X(8).
      *    * クライアントＡＰＬ名称
           10  ON-LUNE-NAME        PIC  X(2).
      *    * 自オンライン名称
           10  FILLER              PIC  X(6).
      *    * 予備１
           10  SV-GROUP            PIC  X(31).
      *    * サービスグループ
           10  SV-NAME             PIC  X(31).
      *    * サービス名称
           10  START-TYPE          PIC  X(2).
      *    * サービス起動形態
           10  PROC-NAME           PIC  X(16).
      *    * プロセス名称
           10  ORG-SV-GROUP        PIC  X(31).
      *    * オリジナルサービスグループ名称
           10  ORG-SV-NAME         PIC  X(31).
      *    * オリジナルサービス名称
           10  ORG-START-TYPE      PIC  X(2).
      *    * オリジナル起動形態
           10  MONITER-SW          PIC  X(1).
      *    * モニタ取得区分
           10  AP-COMPLETE-ST      PIC  X(1).
      *    * ＡＰ終了ステータス
           10  MDL-COMPL-ST        PIC  X(1).
      *    * ミドル終了ステータス
           10  TROUBLE-SW          PIC  X(1).
      *    * 障害区分
           10  FORCE-SW            PIC  X(1).
      *    * 強制区分
           10  FILLER              PIC  X(3).
      *    * 予備２
           10  IN-NO               PIC  S9(4)
                                   USAGE IS COMP-5.
      *    * 入力通番
           10  IN-HOST-NAME        PIC  X(32).
      *    * 入力端末のコンピュータ名称
           10  COMPANY-CODE        PIC  X(4).
      *    * 会社コード
           10  IN-ST-CODE          PIC  X(4).
      *    * 顧客処理部店コード
           10  IN-ST-DBNAME        PIC  X(32).
      *    * 営業店ＤＢサーバ名称
           10  FILLER              PIC  X(6).
      *    * 予備３
           10  JOB-USER-ID         PIC  X(8).
      *    * 端末利用者の業務ユーザＩＤ
           10  JOB-RANK-01         PIC  X(2).
      *    * 端末利用者の業務ランク０１ #PSD-201
           10  JOB-RANK-02         PIC  X(2).
      *    * 端末利用者の業務ランク０２ #PSD-201
           10  JOB-RANK-03         PIC  X(2).
      *    * 端末利用者の業務ランク０３ #PSD-201
           10  JOB-RANK-04         PIC  X(2).
      *    * 端末利用者の業務ランク０４ #PSD-201
           10  JOB-RANK-05         PIC  X(2).
      *    * 端末利用者の業務ランク０５ #PSD-201
           10  JOB-RANK-06         PIC  X(2).
      *    * 端末利用者の業務ランク０６ #PSD-201
           10  JOB-RANK-07         PIC  X(2).
      *    * 端末利用者の業務ランク０７ #PSD-201
           10  JOB-RANK-08         PIC  X(2).
      *    * 端末利用者の業務ランク０８ #PSD-201
           10  JOB-RANK-09         PIC  X(2).
      *    * 端末利用者の業務ランク０９ #PSD-201
           10  JOB-RANK-10         PIC  X(2).
      *    * 端末利用者の業務ランク１０ #PSD-201
           10  USER-IN-ST          PIC  X(4).
      *    * ユーザ所属部店
           10  SV-ERR-CD           PIC  X(4).
      *    *サーバ詳細コード      #PCL309
           10  RLY-RPC-TM          PIC  S9(4)
                                   USAGE IS COMP-5.
      *    *問合せ応答タイマ      #PCL301
           10  FILLER              PIC  X(54).
      *    * 予備５ #PSD-201 #PCL301,#PCL309
