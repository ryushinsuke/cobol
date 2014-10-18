      ******************************************************************
      *
      *  システムＩＤ   : T-STAR
      *  システム名称   : 新有価証券バックオフィスシステム
      *  コピー句ＩＤ   : TKDYAA31.cpy
      *  コピー句名称   : 実行状況管理
      *
      *  改訂履歴
      *  年月日     所属       担当者  内容
      *  ---------- ---------- ------  ----------------------------
      *  2011/10/10 NRI               新規
      *
      ******************************************************************

      *----------  利用会社コード
       20  RIYO-CMP-CD                             PIC  X(04).
      *----------  処理実行日
       20  SYORI-YMD                               PIC  S9(08).
      *----------  起動ID
       20  KIDOU-ID                                PIC  X(04).
      *----------  アクセス日時
       20  ACC-TIME                                PIC  X(14).
      *----------  アクセスIPアドレス
       20  ACC-IP                                  PIC  X(15).
      *----------  起動ログインユーザ会社コード
       20  KIDOU-LOGIN-CMP-CD                      PIC  X(04).
      *----------  起動ユーザーID
       20  KIDOU-SID                               PIC  X(20).
      *----------  起動業務グループコード
       20  KIDOU-GYOMU-GRP-CD                      PIC  X(10).
      *----------  タスクスケジュール起動ID
       20  TSK-SCHE-KIDOU-ID                       PIC  X(04).
      *----------  タスクスケジュールID
       20  TSK-SCHE-ID                             PIC  X(07).
      *----------  タスクスケジュール明細ID
       20  TSK-SCHE-MS-ID                          PIC  S9(03).
      *----------  業務タスクID
       20  GYOMU-TASK-ID                           PIC  X(07).
      *----------  先行タスクスケジュール明細ID１
       20  SK-TSK-SCHE-MS-ID1                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID２
       20  SK-TSK-SCHE-MS-ID2                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID３
       20  SK-TSK-SCHE-MS-ID3                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID４
       20  SK-TSK-SCHE-MS-ID4                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID５
       20  SK-TSK-SCHE-MS-ID5                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID６
       20  SK-TSK-SCHE-MS-ID6                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID７
       20  SK-TSK-SCHE-MS-ID7                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID８
       20  SK-TSK-SCHE-MS-ID8                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID９
       20  SK-TSK-SCHE-MS-ID9                      PIC  S9(03).
      *----------  先行タスクスケジュール明細ID１０
       20  SK-TSK-SCHE-MS-ID10                     PIC  S9(03).
      *----------  起動時刻
       20  KIDOU-TIME                              PIC  X(06).
      *----------  起動経路
       20  KIDOU-KEIRO                             PIC  X(01).
      *----------  待機ファイル有効区分
       20  TAIKI-FILE-KBN                          PIC  X(01).
      *----------  タイムアウト時間（分）
       20  TIMEOUT-MINUTES                         PIC  S9(04).
      *----------  集信区分
       20  SYUSIN-KBN                              PIC  X(01).
      *----------  取得先区分
       20  SYUTOKUSAKI-KBN                         PIC  X(01).
      *----------  取得方式
       20  SYUTOKU-HOUSIKI                         PIC  X(01).
      *----------  取得ファイル区分
       20  SYUTOKU-FILE-KBN                        PIC  X(01).
      *----------  起動処理分類
       20  KIDOU-SYORI-BUNRUI                      PIC  X(01).
      *----------  実行ステータス
       20  JIKOU-STS                               PIC  X(03).
      *----------  集信ステータス
       20  SYUSIN-STS                              PIC  X(03).
      *----------  集信リトライ数
       20  SYUSIN-RETRY-NUM                        PIC  S9(04).
      *----------  集信MAX回数
       20  SYUSIN-MAX-NUM                          PIC  S9(04).
      *----------  集信終了日時
       20  SYUSIN-END-TIME                         PIC  X(14).
      *----------  一時停止区分
       20  ITIJI-TEISHI-KBN                        PIC  X(01).
      *----------  実行開始日時
       20  JIKOU-START-TIME                        PIC  X(14).
      *----------  実行終了日時
       20  JIKOU-END-TIME                          PIC  X(14).
      *----------  作表シェル終了日時
       20  SHELL-END-TIME                          PIC  X(14).
      *----------  ダウンロードファイル名
       20  DL-FILE-NAME                            PIC  X(100).
      *----------  ダウンロード出力区分
       20  DL-FILE-KBN                             PIC  X(01).
      *----------  AQ投入ステータス
       20  AQ-TOUNYU-STS                           PIC  X(01).
      *----------  AQメッセージ
       20  AQ-MSG                                  PIC  X(2000).
      *----------  アップロードファイル総件数
       20  UPLOAD-FILE-KENSU                       PIC  S9(06).
      *----------  アップロードエラー件数
       20  UPLOAD-ERR-KENSU                        PIC  S9(06).
      *----------  帳票作成単位
       20  REP-CREATE-TANI                         PIC  X(01).
      *----------  ファイル種別
       20  REP-OUT-KBN                             PIC  X(01).
      *----------  プリンタID
       20  PRINTER-ID                              PIC  X(20).
      *----------  連続起動集約区分
       20  SYUUYAKU-KBN                            PIC  X(01).
      *----------  親起動ID
       20  OYA-KIDOU-ID                            PIC  X(04).
      *----------  削除区分
       20  DEL-KBN                                 PIC  X(01).
      *----------  更新日時
       20  UPD-DATE                                PIC  X(14).
      *----------  更新ログインユーザ会社コード
       20  UPD-LOGIN-CMP-CD                        PIC  X(04).
      *----------  更新ユーザID
       20  UPD-SID                                 PIC  X(20).
      *----------  更新プログラムID
       20  UPD-PGMID                               PIC  X(16).
      *----------  自動運用カレンダーID
       20  AUTO-CAL-ID                             PIC  X(08).
      *----------  タスクスケジュールNo
       20  TSK-SCHE-NO                             PIC  S9(02).
      *----------  先行タスクスケジュールNo１
       20  SK-TSK-SCHE-NO1                         PIC  S9(02).
      *----------  先行タスクスケジュールNo２
       20  SK-TSK-SCHE-NO2                         PIC  S9(02).
      *----------  先行タスクスケジュールNo３
       20  SK-TSK-SCHE-NO3                         PIC  S9(02).
      *----------  先行タスクスケジュールNo４
       20  SK-TSK-SCHE-NO4                         PIC  S9(02).
      *----------  先行タスクスケジュールNo５
       20  SK-TSK-SCHE-NO5                         PIC  S9(02).
      *----------  先行タスクスケジュールNo６
       20  SK-TSK-SCHE-NO6                         PIC  S9(02).
      *----------  先行タスクスケジュールNo７
       20  SK-TSK-SCHE-NO7                         PIC  S9(02).
      *----------  先行タスクスケジュールNo８
       20  SK-TSK-SCHE-NO8                         PIC  S9(02).
      *----------  先行タスクスケジュールNo９
       20  SK-TSK-SCHE-NO9                         PIC  S9(02).
      *----------  先行タスクスケジュールNo１０
       20  SK-TSK-SCHE-NO10                        PIC  S9(02).
      *----------  AQ投入日時
       20  AQ-TOUNYU-TIME                          PIC  X(14).
      *----------  AQ再投入日時
       20  AQ-SAITOUNYU-TIME                       PIC  X(14).
      *----------  実行再開日時
       20  JIKOU-RESTART-TIME                      PIC  X(14).
      *----------  停止受付日時
       20  TEISHI-UKETSUKE-TIME                    PIC  X(14).
      *----------  停止完了日時
       20  TEISHI-KANRYOU-TIME                     PIC  X(14).
      *----------  親タスク終了日時
       20  OYA-TSK-END-TIME                        PIC  X(14).
