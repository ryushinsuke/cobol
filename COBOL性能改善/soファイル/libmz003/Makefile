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
LOADNAME	=	libmz003.so

# ベースディレクトリは適宜追加・修正してください
BASEDIR		=	/home/apl/debug/PF
BASEDIRBL	=	/home/aplpf/BL
BASEDIRCMN	=	/eLIBSYS/T21/reference_space/develop/dev_Ph20km_NIBUAT/gut-xulequn/makefile/cmn
MKLOGDIR	=	/home/aplelib/debug/dev_Ph20km_NIBUAT/MZ/libmz003

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
OBJS	=	SMZC1000.o\
                SMZC1001.o\
                SMZC1005.o\
                SMZC1006.o\
                SMZC1008.o\
                SMZC1009.o\
                SMZC1010.o\
                SMZC1050.o\
                SMZC1052.o\
                SMZC1054.o\
                SMZC1055.o\
                SMZC1056.o\
                SMZC1059.o\
                SMZC1060.o\
                SMZC1062.o\
                SMZC1063.o\
                SMZC1066.o\
                SMZC1067.o\
                SMZC1068.o\
                SMZC1069.o\
                SMZC1070.o\
                SMZC1071.o\
                SMZC1072.o\
                SMZC1073.o\
                SMZC1074.o\
                SMZC1075.o\
                SMZC1077.o\
                SMZC1078.o\
                SMZC1079.o\
                SMZC1100.o\
                SMZC1101.o\
                SMZC1102.o\
                SMZC1103.o\
                SMZC1104.o\
                SMZC1108.o\
                SMZC1109.o\
                SMZC1110.o\
                SMZC1111.o\
                SMZC1112.o\
                SMZC1113.o\
                SMZC1150.o\
                SMZC1151.o\
                SMZC1152.o\
                SMZC1153.o\
                SMZC1154.o\
                SMZC1155.o\
                SMZC1156.o\
                SMZC1157.o\
                SMZC1158.o\
                SMZC1159.o\
                SMZC1160.o\
                SMZC1161.o\
                SMZC1162.o\
                SMZC1164.o\
                SMZC1165.o\
                SMZC1166.o\
                SMZC1167.o\
                SMZC1168.o\
                SMZC1200.o\
                SMZC1201.o\
                SMZC1204.o\
                SMZC1205.o\
                SMZC1207.o\
                SMZC1208.o\
                SMZC1209.o\
                SMZC1210.o\
                SMZC1250.o\
                SMZC1252.o\
                SMZC1253.o\
                SMZC1256.o\
                SMZC1257.o\
                SMZC1258.o\
                SMZC1259.o\
                SMZC1262.o\
                SMZC1263.o\
                SMZC1264.o\
                SMZC1265.o\
                SMZC1266.o\
                SMZC1267.o\
                SMZC1268.o\
                SMZC1269.o\
                SMZC1300.o\
                SMZC1301.o\
                SMZC1302.o\
                SMZC1303.o\
                SMZC1305.o\
                SMZC1306.o\
                SMZC1307.o\
                SMZC1308.o\
                SMZC1309.o\
                SMZC1310.o\
                SMZC1313.o\
                SMZC1314.o\
                SMZC1350.o\
                SMZC1351.o\
                SMZC1352.o\
                SMZC1353.o\
                SMZC1354.o\
                SMZC1355.o\
                SMZC1400.o\
                SMZC1402.o\
                SMZC1403.o\
                SMZC1404.o\
                SMZC1405.o\
                SMZC1406.o\
                SMZC1407.o\
                SMZC1408.o\
                SMZC1410.o\
                SMZC1411.o\
                SMZC1412.o\
                SMZC1413.o\
                SMZC1414.o\
                SMZC1415.o\
                SMZC1416.o\
                SMZC1417.o\
                SMZC1418.o\
                SMZC1500.o\
                SMZC1501.o\
                SMZC1502.o\
                SMZC1503.o\
                SMZC1550.o\
                SMZC1551.o\
                SMZC1600.o\
                SMZC1601.o\
                SMZC1650.o\
                SMZC1651.o\
                SMZC1700.o\
                SMZC1701.o\
                SMZC1950.o\
                SMZC1951.o\
                SMZC1952.o\
                SMZC1953.o\
                SMZC1954.o\
                SMZC1955.o\
                SMZC1956.o\
                SMZC1957.o\
                SMZC1958.o\
                SMZC1959.o\
                SMZC1960.o\
                SMZC1961.o\
                SMZC3005.o\
                SMZCJ501.o\
                SMZCJ511.o\
                SMZCJ581.o\
                SMZCJ591.o\
                SMZCJ531.o\
                SMZCJ561.o\
                SMZCJ601.o\
                SMZCJ621.o\
                SMZCJ801.o\
                SMZCJ802.o\
                SMZCJ803.o\
                SMZCJ804.o\
                SMZJ1210.o\
                SMZJ1510.o\
                SMZJ1610.o\
                SMZJ1710.o\
                SMZJ1810.o\
                SMZJ1820.o\
                SMZJ1910.o\
                SMZJ1911.o\
                SMZJ1912.o\
                SMZJ1913.o\
                SMZJ1914.o\
                SMZJ1915.o\
                SMZJ1916.o\
                SMZJ1920.o\
                SMZJ1921.o\
                SMZJ1930.o\
                SMZJ1940.o\
                SMZJ1950.o\
                SMZJ2110.o\
                SMZJ2120.o\
                SMZJ2130.o\
                SMZJ2140.o\
                SMZJ2150.o\
                SMZJ2210.o\
                SMZJ2310.o\
                SMZJ2610.o\
                SMZJ2611.o\
                SMZJ2612.o\
                SMZJ4011.o\
                SMZJ4012.o\
                SMZJ4013.o\
                SMZJ4015.o\
                SMZJ4016.o\
                SMZJ4017.o\
                SMZJ4018.o\
                SMZJ4019.o\
                SMZJ4091.o\
                SMZJ5010.o\
                SMZJ5011.o\
                SMZJ6010.o\
                SMZJ6011.o\
                SMZJ6210.o\
                SMZJ6211.o\
                SMZJ8010.o\
                SMZJ8011.o\
                SMZC1270.o\
                SMZC1271.o\
                SMZC1080.o\
                SMZC1081.o\
                SMZC1169.o\
                SMZC1170.o\
                SMZC1171.o\
                SMZC1172.o\
                SMZCJ541.o\
                SMZJ4020.o\
                SMZJ0260.o\
                SMZJ0170.o\
                SMZC0101.o\
                SMZC0102.o\
                SMZC0103.o\
                SMZC1211.o\
                SMZJ4021.o\
                SMZJ7010.o\
                SMZJ7020.o\
                SMZJ7022.o\
                SMZJ7024.o\
                SMZJ7026.o\
                SMZJ7030.o\
                SMZC1114.o\
                SMZC1115.o\
                SMZJ1917.o\
                SMZJ1922.o\
                SMZJ2132.o\
                SMZJ2134.o\
                SMZJ2135.o\
                SMZJ2131.o\
                SMZJ2133.o\
                SMZJ0190.o\
                SMZC1315.o\
                SMZJ4022.o\
                SMZC3008.o\
                SMZC3058.o\
                SMZC3260.o\
                SMZC1116.o\
                SMZC1117.o\
                SMZC1118.o\
                SMZC1119.o\
                SMZC1212.o\
                SMZC1504.o\
                SMZJ2211.o\
                SMZJ4023.o\
                SMZJ1711.o\
                SMZC1120.o\
                SMZCJ611.o\
                SMZJ6110.o\
                SMZJ6111.o\
                SMZC1121.o\
                SMZC1122.o\
                SMZC1505.o\
                SMZC1123.o\
                SMZC1124.o\
                SMZCJ551.o\
                SMZC0104.o\
                SMZC1213.o\
                SMZC1214.o\
                SMZC1273.o\
                SMZC1274.o\
                SMZC1356.o\
                SMZC1357.o\
                SMZC1358.o\
                SMZC1359.o\
                SMZC1419.o\
                SMZC1552.o\
                SMZC1553.o\
                SMZC1652.o\
                SMZC1653.o\
                SMZJ1712.o\
                SMZJ7310.o\
                SMZJ7040.o\
                SMZJ7042.o\
                SMZJ7044.o\
                SMZJ7046.o

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
