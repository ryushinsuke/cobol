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
LOADNAME	=	libmh003.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/MH/libmh003

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
OBJS	=	SMHC1010.o\
            SMHC1020.o\
            SMHC2010.o\
            SMHC3010.o\
            SMHC4010.o\
            SMHC5010.o\
            SMHC6010.o\
            SMHC7020.o\
            SMHC8010.o\
            SMHJ1110.o\
            SMHJ1810.o\
            SMHJ2010.o\
            SMHJ2410.o\
            SMHJ2510.o\
            SMHJ2610.o\
            SMHJ2810.o\
            SMHJ3010.o\
            SMHJ3210.o\
            SMHJ3211.o\
            SMHJ3212.o\
            SMHJ3410.o\
            SMHJ3810.o\
            SMHJ4210.o\
            SMHJ4211.o\
            SMHJ4214.o\
            SMHJ4215.o\
            SMHJ4216.o\
            SMHJ4218.o\
            SMHJ4220.o\
            SMHJ4222.o\
            SMHJ4224.o\
            SMHJ4226.o\
            SMHJ4228.o\
            SMHJ4230.o\
            SMHJ4232.o\
            SMHJ4234.o\
            SMHJ4236.o\
            SMHJ4238.o\
            SMHJ4240.o\
            SMHJ4242.o\
            SMHJ4244.o\
            SMHJ4246.o\
            SMHJ4250.o\
            SMHJ4251.o\
            SMHJ4252.o\
            SMHJ4254.o\
            SMHJ4256.o\
            SMHJ4258.o\
            SMHJ4260.o\
            SMHJ4262.o\
            SMHJ4264.o\
            SMHJ4266.o\
            SMHJ4268.o\
            SMHJ4272.o\
            SMHJ4274.o\
            SMHJ4276.o\
            SMHJ4278.o\
            SMHJ4299.o\
            SMHJ4320.o\
            SMHJ4322.o\
            SMHJ4324.o\
            SMHJ4360.o\
            SMHJ4411.o\
            SMHJ4422.o\
            SMHJ4431.o\
            SMHJ4432.o\
            SMHJ4225.o\
            SMHJ4259.o\
            SMHJ4280.o\
            SMHJ4510.o\
            SMHJ4610.o\
            SMHJ5010.o\
            SMHJ5210.o\
            SMHJ5810.o\
            SMHCCH96.o\
            SMHCCH97.o\
            SMHCCH98.o\
            SMHJ8210.o\
            SMHJ8211.o\
            SMHJ8212.o\
            SMHJ8213.o\
            SMHJ8215.o\
            SMHJ8217.o\
            SMHJ8224.o\
            SMHJ8225.o\
            SCZY4301.o\
            SMHR0711.o\
            SMHR0712.o\
            SCZY4200.o\
            SMHJ9010.o\
            SMHJ9012.o\
            SMHJ9014.o\
            SMHJ9016.o\
            SMHJ9018.o\
            SMHC0208.o\
            SMHR0110.o\
            SMHR0102.o\
            SMHR0702.o\
            SMHR0703.o\
            SMHR0704.o\
            SCZY3025.o\
            SMHJ4612.o\
            SMHC9020.o\
            SMHJ9110.o\
            SMHJ9120.o\
            SMHJ9130.o\
            SMHJ9020.o\
            SMHJ4229.o\
            SMHJ4247.o\
            SMHJ4265.o\
            SMHJ4227.o\
            SMHJ4243.o\
            SMHJ4261.o\
            SMHJ4279.o\
            SMHJ8214.o\
            SMHJ8216.o\
            SMHJ8230.o\
            SMHJ8231.o\
            SMHJ8232.o



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
