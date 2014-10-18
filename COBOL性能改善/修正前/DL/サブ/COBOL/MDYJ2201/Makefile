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
PGMTYPE         =       BATCH

#数値の18桁以上対応用フラグ(1:18桁以上対応、1以外：18桁以上未対応)
INTLENFLG       =       1

#適宜名前を修正する
LOADNAME        =       MDYJ2201

# ソースディレクトリなどは適宜追加・修正してください
BASEDIR         =       /home/apl/debug/DY
BASEDIRBL       =       /home/apl/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km130927/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km130927/DY/MDYJ2201
# ORACLEユーザを適宜指定してください。
USERID          =       "/@utstar"
# APL 固有のライブラリがあれば記述してください
APLIB           =       /opt/wou/lib/libwoubs.so \
-lcz000 -lcz001 -lcz100 -lcz101 -lcz109 -ljc002 -lwommd -lpf001 -lpf002 \
-lcm001 -lcm002 -lmx001 -lmx002 -lmx003 -lmx004 -lmx005 -lmx006 -lmx007 \
-lmx008 -lmz001 -lmz002 -lmz003 -lmz004 -lmh001 -lmh002 -lmh003 -lmh004 \
-ljc001 -ldy000


include  $(BASEDIRCMN)/KMN/MK/Makefile.common

# ------------------------------------------------------------------------------
# Load module difinition
# ------------------------------------------------------------------------------
LOAD            =       $(LOADNAME)
# ------------------------------------------------------------------------------
# Object module definition
# ------------------------------------------------------------------------------
# オブジェクトファイルを列挙してください
OBJS            =       MDYJ2201.o

# ------------------------------------------------------------------------------
# XA object definition
# ------------------------------------------------------------------------------
ifeq ($(PGMTYPE),SPP)
  XA_OBJ        =       $(TP1DIR)/spool/trnrmcmd/userobj/dc_trn_allrm.o
else
  XA_OBJ        =
endif

# ------------------------------------------------------------------------------
# ターゲットの記述
# ------------------------------------------------------------------------------

include  $(BASEDIRCMN)/KMN/MK/Makefile.common2

include  $(BASEDIRCMN)/KMN/MK/Makefile.install

