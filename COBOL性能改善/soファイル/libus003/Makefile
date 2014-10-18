#********************************************************************************
#    プロジェクト  :次期T-STAR
#    サブシステム  :
#    モジュール名  :Makefile
#    名称          :メイクファイル
#
#    使用方法      :適宜修正して使用
#
#================================================================================
#  Copyright (C) 2006 by Nomura Research Institute,Ltd.
#  All rights reserved.
#********************************************************************************

#プログラムタイプ(SPP/BATCH/SUB/SLIB/CPY/DDL/SQL)
PGMTYPE		=	SLIB

#適宜名前を修正する
LOADNAME	=	libus003.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/US/libus003

# APL 固有のライブラリがあれば記述してください
APLIB		=

include  $(BASEDIRCMN)/KMN/MK/Makefile.common

# ------------------------------------------------------------------------------
# Load module difinition
# ------------------------------------------------------------------------------
LOAD		=	$(LOADNAME)
# ------------------------------------------------------------------------------
# Object module definition
# ------------------------------------------------------------------------------
# オブジェクトファイルを列挙してください
OBJS	=	SUSR0102.o\
        SUSCR011.o\
        SUSCR012.o\
        SUSCR013.o\
        SUSCR014.o\
        SUSR0302.o\
        SUSCR031.o\
        SUSCR032.o\
        SUSR0402.o\
        SUSCR041.o\
        SUSCR042.o\
        SUSCR043.o\
        SUSCR044.o\
        SUSCR045.o\
        SUSCR046.o\
        SUSCR047.o\
        SUSCR048.o\
        SUSC0107.o\
        SUSR0502.o\
        SUSCR051.o\
        SUSCR052.o\
        SUSCR053.o\
        SUSCR054.o\
        SUSCR055.o\
        SUSCR056.o\
        SUSCR057.o\
        SUSCR058.o\
        SUSCR059.o\
        SUSC0108.o\
        SUSR0602.o\
        SUSCR061.o\
        SUSR0702.o\
        SUSCR071.o\
        SUSR0802.o\
        SUSCR081.o\
        SUSR0902.o\
        SUSR1102.o\
        SUSCR091.o\
        SUSR1002.o\
        SUSR1202.o\
        SUSCR101.o\
        SUSCR102.o\
        SUSJ0102.o\
        SUSJ0202.o\
        SUSC0001.o\
        SUSC0002.o\
        SUSC0003.o\
        SUSC0004.o\
        SUSJ0302.o\
        SUSC0011.o\
        SUSC0012.o\
        SUSC0013.o\
        SUSR2102.o\
        SUSR2202.o\
        SUSR2302.o\
        SUSR2402.o\
        SUSR2502.o\
        SUSR2602.o\
        SUSR2802.o\
        SUSJ0402.o\
        SUSC0103.o\
        SUSC1070.o\
        SUSJ0502.o\
        SUSC0104.o\
        SUSC1080.o\
        SUSC0105.o\
        SUSC0106.o\
        SUSC0111.o\
        SUSC0112.o\
        SUSC0113.o\
        SUSC0114.o\
        SUSC0115.o\
        SUSC0117.o\
        SUSC0051.o\
        SUSC0052.o\
        SUSC0053.o\
        SUSC0054.o\
        SUSC0055.o\
        SUSC0056.o\
        SUSC0058.o\
        SUSC0059.o\
        SUSC0201.o\
        SUSC0202.o\
        SUSC0203.o\
        SUSC0204.o\
        SUSC0205.o\
        SUSC0206.o\
        SUSC0207.o\
        SUSC0208.o\
        SUSC0301.o\
        SUSC0302.o\
        SUSC0303.o\
        SUSC0304.o\
        SUSC0305.o\
        SUSC0401.o\
        SUSC0402.o\
        SUSC0403.o\
        SUSC0404.o\
        SUSC0405.o\
        SUSC0501.o\
        SUSC0502.o\
        SUSC0503.o\
        SUSC0601.o\
        SUSC0602.o\
        SUSC1075.o\
        SUSC1085.o\
        SUSC0057.o\
        SUSC0603.o\
        SUSC0604.o\
        SUSC0605.o\
        SUSC0116.o\
        SUSCR021.o\
        SUSCR022.o\
        SUSCR023.o\
        SUSCR024.o\
        SUSCR025.o\
        SUSCR026.o\
        SUSCR027.o\
        SUSCR028.o\
        SUSC0406.o\
        SUSC0121.o\
        SUSCR121.o\
        SUSC0122.o\
        TIUSCH44.o\
        SCZY4801.o\
        SUSCR082.o\
        SUSCR083.o\
        SUSCR084.o\
        TIUSCH45.o\
        TIUSCH46.o\
        SUSJ2402.o

# ------------------------------------------------------------------------------
# XA object definition
# ------------------------------------------------------------------------------
ifeq ($(PGMTYPE),SPP)
  XA_OBJ	=	$(TP1DIR)/spool/trnrmcmd/userobj/dc_trn_allrm.o
else
  XA_OBJ	=
endif

# ------------------------------------------------------------------------------
# ターゲットの記述
# ------------------------------------------------------------------------------

include  $(BASEDIRCMN)/KMN/MK/Makefile.common2

include  $(BASEDIRCMN)/KMN/MK/Makefile.install
