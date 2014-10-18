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
PGMTYPE		=	BATCH

#適宜名前を修正する
LOADNAME	=	MUSJ0251

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/Ph20km_NIBUAT/US
BASEDIRBL	=	/home/aplus/BL
BASEDIRCMN	=	/home/apl/debug/.eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/US/MUSJ0251

# APL 固有のライブラリがあれば記述してください
APLIB		=	/opt/wou/lib/libwoubs.so \
          -lcz000 -lcz001 -lcz100 -lcz101 -lcz109 -lus002 -lus003 -lpf002 -ljc001 -ljc002 -lcm001 -lcm002 -lmx001 -lmx002 -lmz001 -lmz002 -lmz003 -lmh001 -lmh002 -lmh003 -lmx008 -lus102

include  $(BASEDIRCMN)/KMN/MK/Makefile.common

# ------------------------------------------------------------------------------
# Load module difinition
# ------------------------------------------------------------------------------
LOAD		=	$(LOADNAME)
# ------------------------------------------------------------------------------
# Object module definition
# ------------------------------------------------------------------------------
# オブジェクトファイルを列挙してください
OBJS	=	MUSJ0251.o

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
