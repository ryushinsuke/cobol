------------------------------------------------------------------------
--     �V�X�e���h�c   : T-STAR
--     �V�X�e������   : �V�L���،��o�b�N�I�t�B�X�V�X�e��
--
--     �r�p�k�h�c     : TKDYAA53
--     �r�p�k����     : �u�œK���Ǘ��e�[�u���vSQL*Loader����t�@�C��
--
--     ��������
--     �N����       ����       �S����  ���e
--     ---------- ---------- ------  ----------------------------
--     2013/02/21   NRI                �V�K

LOAD DATA
INFILE "/home/apl01/BL/mdat/TKDYAA53.dat"
APPEND
INTO TABLE TKDYAA53
FIELDS TERMINATED BY "	"
        (TBL_ID                                            CHAR "NVL(:TBL_ID,' ')"                                               ,
         PRIO                                              INTEGER EXTERNAL "NVL(:PRIO,0)"                                       ,
         TABLE_KBN                                         CHAR "NVL(:TABLE_KBN,' ')"                                            ,
         UPD_DATE                                          DATE "YYYY/MM/DD HH24:MI:SS" "NVL(:UPD_DATE,'20070101000000')"        ,
         UPD_LOGIN_CMP_CD                                  CHAR "NVL(:UPD_LOGIN_CMP_CD,' ')"                                     ,
         UPD_SID                                           CHAR "NVL(:UPD_SID,' ')"                                              ,
         UPD_PGMID                                         CHAR "NVL(:UPD_PGMID,' ')"                                            )
