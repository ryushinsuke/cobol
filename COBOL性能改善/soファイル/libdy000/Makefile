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
LOADNAME	=	libdy000.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/DY/libdy000

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
OBJS	=	SDYC0010.o\
  SDYC0020.o\
  SDYC0030.o\
	SDYJ0701.o\
	SDYJ0702.o\
	SDYJ0703.o\
	SDYR1601.o\
	SDYR1602.o\
	SDYR1603.o\
	SDYJ6001.o\
	SDYJ6002.o\
	SDYJ6003.o\
	SDYJ6004.o\
	SDYJ6005.o\
	SDYJ6006.o\
	SDYJ6007.o\
	SDYJ6008.o\
	SDYJ6009.o\
	SDYJ6010.o\
	SDYJ6011.o\
	SDYJ6012.o\
	SDYJ6013.o\
	SDYJ6014.o\
	SDYJ6015.o\
	SDYJ6016.o\
	SDYJ6017.o\
	SDYJ6018.o\
	SDYJ6019.o\
	SDYJ6020.o\
	SDYJ6021.o\
	SDYJ6022.o\
	SDYJ6023.o\
	SDYJ6024.o\
	SDYJ6025.o\
	SDYJ6026.o\
	SDYJ6027.o\
	SDYJ6028.o\
	SDYJ6029.o\
	SDYJ6030.o\
	SDYJ6031.o\
	SDYJ6100.o\
	SDYJ2301.o

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
