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

#適宜名前を修正する
LOADNAME        =       MDYJ2001

# ベースディレクトリは適宜追加・修正してください
BASEDIR         =       /home/apl/debug/Ph20km/DY
BASEDIRBL       =       /home/apldy/BL
BASEDIRCMN      =       /eLIBSYS/T21/reference_space/develop/dev_Ph20km130222/makefile/cmn
MKLOGDIR        =       /home/aplelib/debug/dev_Ph20km130222/DY/MDYJ2001

# APL 固有のライブラリがあれば記述してください
APLIB           =       -lcz000 -lcz001 -lcz100 -lcz101

include  $(BASEDIRCMN)/KMN/MK/Makefile.common

# ------------------------------------------------------------------------------
# Load module difinition
# ------------------------------------------------------------------------------
LOAD            =       $(LOADNAME)
# ------------------------------------------------------------------------------
# Object module definition
# ------------------------------------------------------------------------------
# オブジェクトファイルを列挙してください
OBJS    =       MDYJ2001.o

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


