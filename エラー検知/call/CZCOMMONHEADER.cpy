      ******************************************************************
      *
      *  システムＩＤ   : T-STAR
      *  システム名称   : 新有価証券バックオフィスシステム
      *  コピー句ＩＤ   : CZCOMMONHEADER.cpy
      *  コピー句名称   : 共通ヘッダ
      *
      *  改訂履歴
      *  年月日     所属       担当者  内容
      *  ---------- ---------- ------  ----------------------------
      *  2006/08/21 SCS                新規
      *
      ******************************************************************
      *----------  リクエストID
       10  REQUEST-ID                        PIC  X(32).
      *----------  システム日付
       10  SYS-DATE                          PIC  X(08).
      *----------  ログインユーザ会社業務形態区分
       10  COMPANY-TYPE                      PIC  X(01).
      *----------  ユーザー名称
       10  USER-NAME                         PIC  X(40).
      *----------  ユーザー種別
       10  USER-TYPE                         PIC  X(01).
      *----------  業務グループコード
       10  GYOUMU-GROUP-CODE                 PIC  X(10).
      *----------  業務グループ名称
       10  GYOUMU-GROUP-NAME                 PIC  X(40).
      *----------  メニュー利用制限区分
       10  ALL-MENU-USABLE                   PIC  X(01).
      *----------  業務タスク利用制限区分
       10  ALL-TASK-USABLE                   PIC  X(01).
      *----------  帳票利用制限区分
       10  ALL-REPORT-USABLE                 PIC  X(01).
      *----------  利用会社コード
       10  RIYO-COMPANY-CODE                 PIC  X(04).
      *----------  利用会社名称
       10  RIYO-COMPANY-NAME                 PIC  X(60).
      *----------  利用会社業務形態区分
       10  RIYO-COMPANY-TYPE                 PIC  X(01).
      *----------  委託会社コード
       10  ITAKU-CODE                        PIC  X(03).
      *----------  受託銀行コード
       10  JYUTAKU-CODE                      PIC  X(02).
      *----------  システムエラーメッセージ
       10  SYSTEM-ERROR-MSG                  PIC  X(60).
      *----------  予備
       10  FILLER                            PIC  X(35).
