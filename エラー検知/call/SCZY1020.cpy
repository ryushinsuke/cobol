      ******************************************************************
      *
      *  VXehc   : T-STAR
      *  VXe¼Ì   : úTSTARVXe
      *  Rs[åhc   : SCZY1020.cpy
      *  Rs[å¼Ì   : J_[[`Rs[å
      *
      *  üùð
      *  Nú     ®       SÒ  àe
      *  ---------- ---------- ------  ----------------------------
      *  20070926   SCS        µÌÌ   VK
      *
      ******************************************************************

         05  PARM-SCZY1020-ARG1.                                       
      *---------- @\æª
             10  IXCAL-FUNCTION         PIC  X(01).
      *---------- îNúP
             10  IXCAL-KJN-YMD1.
                 15  IXCAL-YY-1         PIC  9(04).
                 15  IXCAL-MM-1         PIC  9(02).
                 15  IXCAL-DD-1         PIC  9(02).
             10  IXCAL-KJN-YMD-1  REDEFINES  IXCAL-KJN-YMD1
                                        PIC  9(08).
      *---------- vZx[Xæª
             10  IXCAL-COMP-BASE        PIC  X(01).
      *---------- OãæªP
             10  IXCAL-ZENGO-KBN-1      PIC  X(01).
      *---------- OãæªQ
             10  IXCAL-ZENGO-KBN-2      PIC  X(01).
      *---------- PÊæª
             10  IXCAL-TANI-KBN         PIC  X(01).
      *---------- ú
             10  IXCAL-COMP-DAYS.
                 15  IXCAL-DAYS         PIC  S9(05)V9(06) COMP-3.
      *---------- îNúQ
             10  IXCAL-KJN-YMD2.
                 15  IXCAL-YY-2         PIC  9(04).
                 15  IXCAL-MM-2         PIC  9(02).
                 15  IXCAL-DD-2         PIC  9(02).
             10  IXCAL-KJN-YMD-2  REDEFINES  IXCAL-KJN-YMD2
                                        PIC  9(08).
      *---------- îúQ|jú
             10  IXCAL-KJN-2-YOBI       PIC  S9(02) COMP-3.
      *---------- ZoútcÆúïúæª
         05  PARM-SCZY1020-ARG2.                                       
             10  IXCAL-HIZUKE-KBN       PIC  X(04).
                