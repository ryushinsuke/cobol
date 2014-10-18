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
LOADNAME	=	libmz002.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/MZ/libmz002

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
OBJS	=	SMZC0000.o\
                SMZC0001.o\
                SMZC0002.o\
                SMZC0003.o\
                SMZC3000.o\
                SMZC3002.o\
                SMZC3003.o\
                SMZC3004.o\
                SMZC3006.o\
                SMZC3007.o\
                SMZC3050.o\
                SMZC3053.o\
                SMZC3056.o\
                SMZC3057.o\
                SMZC3150.o\
                SMZC3151.o\
                SMZC3152.o\
                SMZC3153.o\
                SMZC3154.o\
                SMZC3200.o\
                SMZC3201.o\
                SMZC3202.o\
                SMZC3204.o\
                SMZC3250.o\
                SMZC3251.o\
                SMZC3252.o\
                SMZC3253.o\
                SMZC3254.o\
                SMZC9200.o\
                SMZJ4014.o\
                SMZJ0101.o\
                SMZR0201.o\
                SMZR0301.o\
                SMZR0501.o\
                SMZJ0180.o\
                SMZE0102.o\
                SCZY4203.o\
                SMZC9201.o\
                SMZCGP01.o\
                TIMZGZ00.o\
                TIMZKK00.o\
                TIMZSK00.o\
                TIMZZR00.o

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
