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
PGMTYPE		=	SUB

#適宜名前を修正する
LOADNAME	=	SUSC0002.o

# ベースディレクトリは適宜追加・修正してください
#BASEDIR		=	/home/apl/debug/Ph20km/US
#BASEDIRBL	=	/home/aplus/BL
BASEDIRCMN	=	/home/apl/debug/.eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/US/SUSC0002

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
OBJS	=

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
