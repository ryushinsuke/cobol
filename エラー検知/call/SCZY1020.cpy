      ******************************************************************
      *
      *  �V�X�e���h�c   : T-STAR
      *  �V�X�e������   : ����TSTAR�V�X�e��
      *  �R�s�[��h�c   : SCZY1020.cpy
      *  �R�s�[�喼��   : �J�����_�[���[�`���R�s�[��
      *
      *  ��������
      *  �N����     ����       �S����  ���e
      *  ---------- ---------- ------  ----------------------------
      *  20070926   SCS        ���̈�   �V�K
      *
      ******************************************************************

         05  PARM-SCZY1020-ARG1.                                       
      *---------- �@�\�敪
             10  IXCAL-FUNCTION         PIC  X(01).
      *---------- ��N�����P
             10  IXCAL-KJN-YMD1.
                 15  IXCAL-YY-1         PIC  9(04).
                 15  IXCAL-MM-1         PIC  9(02).
                 15  IXCAL-DD-1         PIC  9(02).
             10  IXCAL-KJN-YMD-1  REDEFINES  IXCAL-KJN-YMD1
                                        PIC  9(08).
      *---------- �v�Z�x�[�X�敪
             10  IXCAL-COMP-BASE        PIC  X(01).
      *---------- �O��敪�P
             10  IXCAL-ZENGO-KBN-1      PIC  X(01).
      *---------- �O��敪�Q
             10  IXCAL-ZENGO-KBN-2      PIC  X(01).
      *---------- �P�ʋ敪
             10  IXCAL-TANI-KBN         PIC  X(01).
      *---------- ����
             10  IXCAL-COMP-DAYS.
                 15  IXCAL-DAYS         PIC  S9(05)V9(06) COMP-3.
      *---------- ��N�����Q
             10  IXCAL-KJN-YMD2.
                 15  IXCAL-YY-2         PIC  9(04).
                 15  IXCAL-MM-2         PIC  9(02).
                 15  IXCAL-DD-2         PIC  9(02).
             10  IXCAL-KJN-YMD-2  REDEFINES  IXCAL-KJN-YMD2
                                        PIC  9(08).
      *---------- ����Q�|�j��
             10  IXCAL-KJN-2-YOBI       PIC  S9(02) COMP-3.
      *---------- �Z�o���t�c�Ɠ�����敪
         05  PARM-SCZY1020-ARG2.                                       
             10  IXCAL-HIZUKE-KBN       PIC  X(04).
                