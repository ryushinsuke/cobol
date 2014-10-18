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
LOADNAME	=	libcz101.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/CZY/libcz101

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
OBJS	=	TSDYAA20.o \
                TSDYAA26.o \
                TSDYAA31.o \
                TIDYAA31.o \
                TIDYAA32.o \
                TIDYAA35.o \
                TIDYAA36.o \
                TISYAA40.o \
                TISYAA41.o \
                TSSYAA10.o \
                TIDYAA45.o \
                TIDYAA40.o \
                TIDYAA41.o \
                TIDYAA23.o \
                TIDYAA30.o \
                TIDYAA39.o \
                TSDYAA23.o \
                TSDYAA27.o \
                TSDYAA32.o \
                TSDYAA15.o \
                TIDYAA37.o \
                TIDYAA52.o \
                TIEYWK01.o \
                TIEYWK02.o \
                TIEYWK03.o \
                TIDYAA62.o \
                TIDYAA61.o \
                TIDYAA64.o

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
