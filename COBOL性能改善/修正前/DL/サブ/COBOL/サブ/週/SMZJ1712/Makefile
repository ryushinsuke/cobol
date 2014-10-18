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
PGMTYPE         =       SUB

#数値の18桁以上対応用フラグ(1:18桁以上対応、1以外：18桁以上未対応)
INTLENFLG       =       1

#適宜名前を修正する
LOADNAME        =       SMZJ1712.o

# ソースディレクトリなどは適宜追加・修正してください
BASEDIR         =       /home/apl/debug/MZ
BASEDIRBL       =       /home/apl/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km120525/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km120525/MZ/SMZJ1712
# ORACLEユーザを適宜指定してください。
USERID          =       "/@utstar"
# APL 固有のライブラリがあれば記述してください
APLIB           =

include  $(BASEDIRCMN)/KMN/MK/Makefile.common

# ------------------------------------------------------------------------------
# Load module difinition
# ------------------------------------------------------------------------------
LOAD            =       $(LOADNAME)
# ------------------------------------------------------------------------------
# Object module definition
# ------------------------------------------------------------------------------
# オブジェクトファイルを列挙してください
OBJS            =       FFFFFFFF

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

