      ******************************************************************
      *
      *  �V�X�e���h�c   : T-STAR
      *  �V�X�e������   : �V�L���،��o�b�N�I�t�B�X�V�X�e��
      *  �R�s�[��h�c   : TKDYAA31.cpy
      *  �R�s�[�喼��   : ���s�󋵊Ǘ�
      *
      *  ��������
      *  �N����     ����       �S����  ���e
      *  ---------- ---------- ------  ----------------------------
      *  2011/10/10 NRI               �V�K
      *
      ******************************************************************

      *----------  ���p��ЃR�[�h
       20  RIYO-CMP-CD                             PIC  X(04).
      *----------  �������s��
       20  SYORI-YMD                               PIC  S9(08).
      *----------  �N��ID
       20  KIDOU-ID                                PIC  X(04).
      *----------  �A�N�Z�X����
       20  ACC-TIME                                PIC  X(14).
      *----------  �A�N�Z�XIP�A�h���X
       20  ACC-IP                                  PIC  X(15).
      *----------  �N�����O�C�����[�U��ЃR�[�h
       20  KIDOU-LOGIN-CMP-CD                      PIC  X(04).
      *----------  �N�����[�U�[ID
       20  KIDOU-SID                               PIC  X(20).
      *----------  �N���Ɩ��O���[�v�R�[�h
       20  KIDOU-GYOMU-GRP-CD                      PIC  X(10).
      *----------  �^�X�N�X�P�W���[���N��ID
       20  TSK-SCHE-KIDOU-ID                       PIC  X(04).
      *----------  �^�X�N�X�P�W���[��ID
       20  TSK-SCHE-ID                             PIC  X(07).
      *----------  �^�X�N�X�P�W���[������ID
       20  TSK-SCHE-MS-ID                          PIC  S9(03).
      *----------  �Ɩ��^�X�NID
       20  GYOMU-TASK-ID                           PIC  X(07).
      *----------  ��s�^�X�N�X�P�W���[������ID�P
       20  SK-TSK-SCHE-MS-ID1                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�Q
       20  SK-TSK-SCHE-MS-ID2                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�R
       20  SK-TSK-SCHE-MS-ID3                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�S
       20  SK-TSK-SCHE-MS-ID4                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�T
       20  SK-TSK-SCHE-MS-ID5                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�U
       20  SK-TSK-SCHE-MS-ID6                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�V
       20  SK-TSK-SCHE-MS-ID7                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�W
       20  SK-TSK-SCHE-MS-ID8                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�X
       20  SK-TSK-SCHE-MS-ID9                      PIC  S9(03).
      *----------  ��s�^�X�N�X�P�W���[������ID�P�O
       20  SK-TSK-SCHE-MS-ID10                     PIC  S9(03).
      *----------  �N������
       20  KIDOU-TIME                              PIC  X(06).
      *----------  �N���o�H
       20  KIDOU-KEIRO                             PIC  X(01).
      *----------  �ҋ@�t�@�C���L���敪
       20  TAIKI-FILE-KBN                          PIC  X(01).
      *----------  �^�C���A�E�g���ԁi���j
       20  TIMEOUT-MINUTES                         PIC  S9(04).
      *----------  �W�M�敪
       20  SYUSIN-KBN                              PIC  X(01).
      *----------  �擾��敪
       20  SYUTOKUSAKI-KBN                         PIC  X(01).
      *----------  �擾����
       20  SYUTOKU-HOUSIKI                         PIC  X(01).
      *----------  �擾�t�@�C���敪
       20  SYUTOKU-FILE-KBN                        PIC  X(01).
      *----------  �N����������
       20  KIDOU-SYORI-BUNRUI                      PIC  X(01).
      *----------  ���s�X�e�[�^�X
       20  JIKOU-STS                               PIC  X(03).
      *----------  �W�M�X�e�[�^�X
       20  SYUSIN-STS                              PIC  X(03).
      *----------  �W�M���g���C��
       20  SYUSIN-RETRY-NUM                        PIC  S9(04).
      *----------  �W�MMAX��
       20  SYUSIN-MAX-NUM                          PIC  S9(04).
      *----------  �W�M�I������
       20  SYUSIN-END-TIME                         PIC  X(14).
      *----------  �ꎞ��~�敪
       20  ITIJI-TEISHI-KBN                        PIC  X(01).
      *----------  ���s�J�n����
       20  JIKOU-START-TIME                        PIC  X(14).
      *----------  ���s�I������
       20  JIKOU-END-TIME                          PIC  X(14).
      *----------  ��\�V�F���I������
       20  SHELL-END-TIME                          PIC  X(14).
      *----------  �_�E�����[�h�t�@�C����
       20  DL-FILE-NAME                            PIC  X(100).
      *----------  �_�E�����[�h�o�͋敪
       20  DL-FILE-KBN                             PIC  X(01).
      *----------  AQ�����X�e�[�^�X
       20  AQ-TOUNYU-STS                           PIC  X(01).
      *----------  AQ���b�Z�[�W
       20  AQ-MSG                                  PIC  X(2000).
      *----------  �A�b�v���[�h�t�@�C��������
       20  UPLOAD-FILE-KENSU                       PIC  S9(06).
      *----------  �A�b�v���[�h�G���[����
       20  UPLOAD-ERR-KENSU                        PIC  S9(06).
      *----------  ���[�쐬�P��
       20  REP-CREATE-TANI                         PIC  X(01).
      *----------  �t�@�C�����
       20  REP-OUT-KBN                             PIC  X(01).
      *----------  �v�����^ID
       20  PRINTER-ID                              PIC  X(20).
      *----------  �A���N���W��敪
       20  SYUUYAKU-KBN                            PIC  X(01).
      *----------  �e�N��ID
       20  OYA-KIDOU-ID                            PIC  X(04).
      *----------  �폜�敪
       20  DEL-KBN                                 PIC  X(01).
      *----------  �X�V����
       20  UPD-DATE                                PIC  X(14).
      *----------  �X�V���O�C�����[�U��ЃR�[�h
       20  UPD-LOGIN-CMP-CD                        PIC  X(04).
      *----------  �X�V���[�UID
       20  UPD-SID                                 PIC  X(20).
      *----------  �X�V�v���O����ID
       20  UPD-PGMID                               PIC  X(16).
      *----------  �����^�p�J�����_�[ID
       20  AUTO-CAL-ID                             PIC  X(08).
      *----------  �^�X�N�X�P�W���[��No
       20  TSK-SCHE-NO                             PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�P
       20  SK-TSK-SCHE-NO1                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�Q
       20  SK-TSK-SCHE-NO2                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�R
       20  SK-TSK-SCHE-NO3                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�S
       20  SK-TSK-SCHE-NO4                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�T
       20  SK-TSK-SCHE-NO5                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�U
       20  SK-TSK-SCHE-NO6                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�V
       20  SK-TSK-SCHE-NO7                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�W
       20  SK-TSK-SCHE-NO8                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�X
       20  SK-TSK-SCHE-NO9                         PIC  S9(02).
      *----------  ��s�^�X�N�X�P�W���[��No�P�O
       20  SK-TSK-SCHE-NO10                        PIC  S9(02).
      *----------  AQ��������
       20  AQ-TOUNYU-TIME                          PIC  X(14).
      *----------  AQ�ē�������
       20  AQ-SAITOUNYU-TIME                       PIC  X(14).
      *----------  ���s�ĊJ����
       20  JIKOU-RESTART-TIME                      PIC  X(14).
      *----------  ��~��t����
       20  TEISHI-UKETSUKE-TIME                    PIC  X(14).
      *----------  ��~��������
       20  TEISHI-KANRYOU-TIME                     PIC  X(14).
      *----------  �e�^�X�N�I������
       20  OYA-TSK-END-TIME                        PIC  X(14).
