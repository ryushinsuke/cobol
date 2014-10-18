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
LOADNAME	=	libus002.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/US/libus002

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
OBJS	=	SUSC0101.o\
        SUSC0102.o\
        SUSC0109.o\
        SUSC0110.o\
        SUSR0101.o\
        SUSR0301.o\
        SUSR0401.o\
        SUSR0501.o\
        SUSR0601.o\
        SUSR0701.o\
        SUSR0801.o\
        SUSR0901.o\
        SUSR1001.o\
        SUSR1101.o\
        SUSR1201.o\
        SUSJ0101.o\
        SUSJ0201.o\
        SUSJ0301.o\
        SUSR2101.o\
        SUSR2201.o\
        SUSR2301.o\
        SUSR2401.o\
        SUSR2501.o\
        SUSR2601.o\
        SUSR2801.o\
        SUSJ0401.o\
        SUSJ0501.o\
        SUSCR301.o\
        SUSCR302.o\
        SUSCR352.o\
        SUSCR351.o\
        SUSCR342.o\
        SUSCR341.o\
        SUSCR332.o\
        SUSCR331.o\
        SUSCR322.o\
        SUSCR321.o\
        SUSCR312.o\
        SUSCR311.o\
        TIUSWK01.o\
        SUSJ2401.o

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
