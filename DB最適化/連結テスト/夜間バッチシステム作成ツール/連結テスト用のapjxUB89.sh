#! /bin/sh
#-------------------------------------------------------------------------------------------------------------
# �V�X�e���h�c      �F  TSTAR
# �V�X�e������      �F  ����TSTAR�V�X�e��
# ���W���[���h�c    �F  apjxUB89
# ���W���[������    �F  ��ԃo�b�`�V�X�e���쐬
# �����T�v          �F  ��Ԕ�Ў��̖�ԃo�b�`�V�X�e���쐬
# ����              �F  ARG1: go   ARG2: ���s���(yyyymmdd)
# ���^�[���R�[�h    �F  0�F����I��
#                       1�F�ُ�I��
#
# ��������
# �N����    �敪    ����    ���e
# --------  ----    ------  ----------------------------------------------------------------------------------
# 20110105  �V�K    ASK     �V�K�쐬
#
# Copyright (C) 2006 by Nomura Research Institute,Ltd.
# All rights reserved.
#-------------------------------------------------------------------------------------------------------------
# ���ϐ��ݒ�
#-------------------------------------------------------------------------------------------------------------
#���s���
SJ_PEX_DATE=$2
export SJ_PEX_DATE

#���s�t���[����
SJ_PEX_FRAME=apfxC000_xxxRX
export SJ_PEX_FRAME

#���s�W���u��
SJ_PEX_JOB=apjxC000UB89
export SJ_PEX_JOB

#-------------------------------------------------------------------------------------------------------------
# ���[�J���ϐ��ݒ�
#-------------------------------------------------------------------------------------------------------------
#���p��ЃR�[�h
TS_RIYO_CMPCD=`echo ${SJ_PEX_FRAME}|awk '{print substr($1,5,4)}'`

#�o�b�`���O�t�@�C��
DR_LOGFILE=${APL_LOG_DIR}/${TS_RIYO_CMPCD}/${SJ_PEX_JOB}.log

#�W���uSKIP�R�}���h�t�@�C��
DR_SKIPFILE=${NAS_APL_DIR}/4999/work/DR_SKIP.lst

#GEN�`�F�b�N���ʏo�̓f�B���N�g��
DR_GEN_CHECK_DIR=${NAS_APL_DIR}/4999/work

#�V�F���̃��^�[���R�[�h
TS_RCODE=0

#�W���uSKIP�R�}���h
DR_SKIPCMD=""

#�V�F���T�[�o�[
#DR_SHL_SERVER="tduk0047"        #�^�p�Ď��T�[�o�[�i�{�ԁj
DR_SHL_SERVER="RLSJV076"        #�^�p�Ď��T�[�o�[�i�N���E�h���j

#�������f�i�A�v���j
DR_EXEC_APL=0

#�������f�i�j���j
DR_EXEC_HOLI=0

#�������f�i�y�j���j
DR_EXEC_SAT=0

#�������f�X�e�[�^�X
DR_EXEC_STATUS=0

#-------------------------------------------------------------------------------------------------------------
# ��������
#-------------------------------------------------------------------------------------------------------------
BCZC0001.sh                                                                                                                 >> ${DR_LOGFILE}
BCZC0000.sh                                                                                                                 >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# �����m�F
#-------------------------------------------------------------------------------------------------------------
#��������'go'�ł͂Ȃ��ꍇ�uArgument Error�v��\�����A�W���u�ُ�I���B
if [ "$1" != "go" ];then
    echo "Argument Error"                                                                                                   >> ${DR_LOGFILE}
    TS_RCODE=1
    echo "���^�[���R�[�h="${TS_RCODE}                                                                                       >> ${DR_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                                                                                                 >> ${DR_LOGFILE}
    exit ${TS_RCODE}
fi

#���������ݒ肳��Ă��Ȃ��ꍇ�u�^�p���t���w��v��\�����A�W���u�ُ�I���B
if [ "${SJ_PEX_DATE}" = "" ];then
    echo "�^�p���t���w��"                                                                                                   >> ${DR_LOGFILE}
    TS_RCODE=1
    echo "���^�[���R�[�h="${TS_RCODE}                                                                                       >> ${DR_LOGFILE}
    BCZC9999.sh ${TS_RCODE}                                                                                                 >> ${DR_LOGFILE}
    exit ${TS_RCODE}
else
    echo "���s��� �� " ${SJ_PEX_DATE}                                                                                    >> ${DR_LOGFILE}
fi

#-------------------------------------------------------------------------------------------------------------
# �X�e�b�v-0010 �ږ��ԃo�b�`�W�F�l���[�g����
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0010
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

#�X�P�W���[���o�^�u���s�V�X�e���̍쐬�v�ith_RXAPLBT1�j
echo "�V�X�e��[th_RXAPLBT1]�쐬�J�n�E�E�E"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT1 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "�V�X�e��[th_RXAPLBT1]�͈ꕔ�������͑S�Ẵt���[������^�p���̂��ߓo�^����Ȃ��t���[�������݂��邩�A�V�X�e���쐬���s���܂���"      >> ${DR_LOGFILE}
    else
        echo "�V�X�e��[th_RXAPLBT1]�쐬�G���["                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "�V�X�e��[th_RXAPLBT1]�쐬����"                                                                                    >> ${DR_LOGFILE}
fi

#�X�P�W���[���o�^�u���s�V�X�e���̍쐬�v�ith_RXAPLBT2�j
echo "�V�X�e��[th_RXAPLBT2]�쐬�J�n�E�E�E"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT2 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "�V�X�e��[th_RXAPLBT2]�͈ꕔ�������͑S�Ẵt���[������^�p���̂��ߓo�^����Ȃ��t���[�������݂��邩�A�V�X�e���쐬���s���܂���"      >> ${DR_LOGFILE}
    else
        echo "�V�X�e��[th_RXAPLBT2]�쐬�G���["                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "�V�X�e��[th_RXAPLBT2]�쐬����"                                                                                    >> ${DR_LOGFILE}
fi

#�X�P�W���[���o�^�u���s�V�X�e���̍쐬�v�ith_RXAPLBT3�j
echo "�V�X�e��[th_RXAPLBT3]�쐬�J�n�E�E�E"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RXAPLBT3 -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "�V�X�e��[th_RXAPLBT3]�͈ꕔ�������͑S�Ẵt���[������^�p���̂��ߓo�^����Ȃ��t���[�������݂��邩�A�V�X�e���쐬���s���܂���"      >> ${DR_LOGFILE}
    else
        echo "�V�X�e��[th_RXAPLBT3]�쐬�G���["                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_APL=1
    fi
else
    echo "�V�X�e��[th_RXAPLBT3]�쐬����"                                                                                    >> ${DR_LOGFILE}
fi

#�X�P�W���[���o�^�u���s�V�X�e���̍쐬�v�ith_RX�j��BT�j
echo "�V�X�e��[th_RX�j��BT]�쐬�J�n�E�E�E"                                                                                  >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RX�j��BT -d${SJ_PEX_DATE}                                                        >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "�V�X�e��[th_RX�j��BT]�͈ꕔ�������͑S�Ẵt���[������^�p���̂��ߓo�^����Ȃ��t���[�������݂��邩�A�V�X�e���쐬���s���܂���"      >> ${DR_LOGFILE}
    else
        echo "�V�X�e��[th_RX�j��BT]�쐬�G���["                                                                              >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_HOLI=1
    fi
else
    echo "�V�X�e��[th_RX�j��BT]�쐬����"                                                                                    >> ${DR_LOGFILE}
fi

#�X�P�W���[���o�^�u���s�V�X�e���̍쐬�v�ith_RX�y�j��BT�j
echo "�V�X�e��[th_RX�y�j��BT]�쐬�J�n�E�E�E"                                                                                >> ${DR_LOGFILE}
sj_rex ${DR_SHL_SERVER} sjPEX_GEN_all -sth_RX�y�j��BT -d${SJ_PEX_DATE}                                                      >> ${DR_LOGFILE}

TS_STATUS=$?
if [ "${TS_STATUS}" != "0" ]; then
    if [ "${TS_STATUS}" = "206" ]; then
        echo "�V�X�e��[th_RX�y�j��BT]�͈ꕔ�������͑S�Ẵt���[������^�p���̂��ߓo�^����Ȃ��t���[�������݂��邩�A�V�X�e���쐬���s���܂���"    >> ${DR_LOGFILE}
    else
        echo "�V�X�e��[th_RX�y�j��BT]�쐬�G���["                                                                            >> ${DR_LOGFILE}
        DR_EXEC_STATUS=16
        DR_EXEC_SAT=1
    fi
else
    echo "�V�X�e��[th_RX�y�j��BT]�쐬����"                                                                                    >> ${DR_LOGFILE}
fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# �X�e�b�v-0020 �ږ��ԃo�b�`�W�F�l���[�g�`�F�b�N����
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0020
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

if [ "${DR_EXEC_APL}" = "0" ]; then

    #���s�V�X�e���쐬����(th_RXAPLBT1)
    echo "�V�X�e��[th_RXAPLBT1]GEN�`�F�b�N�E�E�E"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT1 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "�V�X�e��[th_RXAPLBT1]�͔�^�p���̂��߃t���[�������͍s���܂���"                                            >> ${DR_LOGFILE}
        else
            echo "�V�X�e��[th_RXAPLBT1]�W�F�l���[�g�`�F�b�N�G���["                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "�V�X�e��[th_RXAPLBT1]�͓����Ώۂł�"                                                                          >> ${DR_LOGFILE}
    fi

    #���s�V�X�e���쐬����(th_RXAPLBT2)
    echo "�V�X�e��[th_RXAPLBT2]GEN�`�F�b�N�E�E�E"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT2 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "�V�X�e��[th_RXAPLBT2]�͔�^�p���̂��߃t���[�������͍s���܂���"                                            >> ${DR_LOGFILE}
        else
            echo "�V�X�e��[th_RXAPLBT2]�W�F�l���[�g�`�F�b�N�G���["                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "�V�X�e��[th_RXAPLBT2]�͓����Ώۂł�"                                                                          >> ${DR_LOGFILE}
    fi

    #���s�V�X�e���쐬����(th_RXAPLBT3)
    echo "�V�X�e��[th_RXAPLBT3]GEN�`�F�b�N�E�E�E"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RXAPLBT3 -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "�V�X�e��[th_RXAPLBT3]�͔�^�p���̂��߃t���[�������͍s���܂���"                                            >> ${DR_LOGFILE}
        else
            echo "�V�X�e��[th_RXAPLBT3]�W�F�l���[�g�`�F�b�N�G���["                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
        fi
    else
        echo "�V�X�e��[th_RXAPLBT3]�͓����Ώۂł�"                                                                          >> ${DR_LOGFILE}
    fi
fi

if [ "${DR_EXEC_HOLI}" = "0" ]; then

    #���s�V�X�e���쐬����(th_RX�j��BT)
    echo "�V�X�e��[th_RX�j��BT]GEN�`�F�b�N�E�E�E"                                                                           >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RX�j��BT -pa2 -dir${DR_GEN_CHECK_DIR}                     >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "�V�X�e��[th_RX�j��BT]�͔�^�p���̂��߃t���[�������͍s���܂���"                                            >> ${DR_LOGFILE}
        else
            echo "�V�X�e��[th_RX�j��BT]�W�F�l���[�g�`�F�b�N�G���["                                                          >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_HOLI=1
        fi
    else
        echo "�V�X�e��[th_RX�j��BT]�͓����Ώۂł�"                                                                          >> ${DR_LOGFILE}
    fi
fi

if [ "${DR_EXEC_SAT}" = "0" ]; then

    #���s�V�X�e���쐬����(th_RX�y�j��BT)
    echo "�V�X�e��[th_RX�y�j��BT]GEN�`�F�b�N�E�E�E"                                                                         >> ${DR_LOGFILE}
    sj_rex ${DR_SHL_SERVER} sjPEX_GEN_check -d${SJ_PEX_DATE} -sth_RX�y�j��BT -pa2 -dir${DR_GEN_CHECK_DIR}                   >> ${DR_LOGFILE}

    TS_STATUS=$?
    if [ "${TS_STATUS}" != "0" ]; then
        if [ "${TS_STATUS}" = "206" ]; then
            echo "�V�X�e��[th_RX�y�j��BT]�͔�^�p���̂��߃t���[�������͍s���܂���"                                          >> ${DR_LOGFILE}
        else
            echo "�V�X�e��[th_RX�y�j��BT]�W�F�l���[�g�`�F�b�N�G���["                                                        >> ${DR_LOGFILE}
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
        fi
    else
        echo "�V�X�e��[th_RX�y�j��BT]�͓����Ώۂł�"                                                                        >> ${DR_LOGFILE}
    fi
fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# �X�e�b�v-0030 �f�B�t�H���gSKIP�ݒ菈��
#-------------------------------------------------------------------------------------------------------------
TS_STEPID=0030
BCZC1100.sh ${TS_STEPID}                                                                                                    >> ${DR_LOGFILE}

if [ "${DR_EXEC_APL}" = "0" ]; then

    #�uapfdC000_200RX�v���o�͂���Ă��邩����
    grep -l "apfdC000_200RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #�l�b�g�ƌ㑱�W���u��A���ŃX�L�b�v�ɐݒ�iapfdC000_200RX:apndC000DY20�`�j(�I�����C����~�`)
        echo "apfdC000_200RX - apndC000DY20�`�㑱SKIP�w��E�E�E"                                                            >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -n -d${SJ_PEX_DATE} -FapfdC000_200RX -NapndC000DY20                           >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfdC000_200RX�t���[��apndC000DY20��NETSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi

        #�l�b�g��P�ƂŃX�L�b�v�ɐݒ�iapfdC000_200RX:apndC000DY23�j(���_����Ď��v���Z�X��~)
        echo "apfdC000_200RX - apndC000DY23�F���_����Ď��v���Z�X��~����SKIP�w��E�E�E"                                    >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -FapfdC000_200RX -NapndC000DY23                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfdC000_200RX�t���[��apndC000DY23��NETSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi
    fi

    #�uapfd1000_100RX�v���o�͂���Ă��邩����
    grep -l "apfd1000_100RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #�l�b�g��P�ƂŃX�L�b�v�ɐݒ�iapfd1000_100RX:apndC000JC10�j(�f�c�a�ڑ�)
        echo "apfd1000_100RX - apndC000JC10:�f�c�a�ڑ�����SKIP�w��E�E�E"                                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -Fapfd1000_100RX -NapndC000JC10                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_APL=1
            echo "apfd1000_100RX�t���[����NETSKIP�ݒ�G���["                                                                >> ${DR_LOGFILE}
        fi
    fi

    #�uapfduuuu_100RX�v�`�o�k�Ɩ��o�b�`(��Е�)�t���[�����o�͂���Ă��邩����
    echo "������Еʃt���[���̃f�t�H���gSKIP�w�菈���J�n�E�E�E"                                                             >> ${DR_LOGFILE}
    for TS_USER_CD in `cat ${APL_DATEFILE_DIR}/USCOM_KIBO_L_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_M_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_S_RX.dat |grep -v '4999'`
    do
        echo "��ЋK�̓t�@�C������擾������ЃR�[�h�F"${TS_USER_CD}                                                        >> ${DR_LOGFILE}
        grep -l "apfd"${TS_USER_CD}"_100RX" ${DR_GEN_CHECK_DIR}/*.txt                                                       >> ${DR_LOGFILE}
        if [ "$?" = "0" ];then

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfduuuu_100RX:apjdC000JC42�j(���ߕۗL�������X�g�쐬)
            echo "apfd"${TS_USER_CD}"_100RX - apndC000JC11 - apjdC000JC42:���ߕۗL�������X�g�쐬����SKIP�w��E�E�E"         >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfd${TS_USER_CD}_100RX -NapndC000JC11 apjdC000JC42    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfd"${TS_USER_CD}"_100RX�t���[��apjdC000JC42��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfduuuu_100RX:apjdC000JC43�j(���ߕۗL�������X�g�e�s�o)
            echo "apfd"${TS_USER_CD}"_100RX - apndC000JC12 - apjdC000JC43:���ߕۗL�������X�gFTP����SKIP�w��E�E�E"          >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfd${TS_USER_CD}_100RX -NapndC000JC12 apjdC000JC43    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfd"${TS_USER_CD}"_100RX�t���[��apjdC000JC43��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi
        else
            echo "������Еʃt���[��apfd"${TS_USER_CD}"_100RX�͓����ΏۊO"                                                  >> ${DR_LOGFILE}
        fi
    done

fi

if [ "${DR_EXEC_HOLI}" = "0" ]; then

    #�uapfd1000_101RX�v���o�͂���Ă��邩����
    grep -l "apfd1000_101RX" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #�l�b�g��P�ƂŃX�L�b�v�ɐݒ�iapfd1000_101RX:apndC000JC10�j(�f�c�a�ڑ�)
        echo "apfd1000_101RX - apndC000JC10:�f�c�a�ڑ�����SKIP�w��E�E�E"                                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -Fapfd1000_101RX -NapndC000JC10                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_HOLI=1
            echo "apfd1000_101RX�t���[����NETSKIP�ݒ�G���["                                                                >> ${DR_LOGFILE}
        fi
    fi
fi

if [ "${DR_EXEC_SAT}" = "0" ]; then

    #�uapfwC000_20RXH�v���o�͂���Ă��邩����
    grep -l "apfwC000_20RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #�l�b�g�ƌ㑱�W���u��A���ŃX�L�b�v�ɐݒ�iapfwC000_20RXH:apndC000DY20�`�j(�I�����C����~�`)
        echo "apfwC000_20RXH - apndC000DY20�`�㑱SKIP�w��E�E�E"                                                            >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -n -d${SJ_PEX_DATE} -FapfwC000_20RXH -NapndC000DY20                           >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_20RXH�t���[��apndC000DY20��NETSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi

        #�l�b�g��P�ƂŃX�L�b�v�ɐݒ�iapfwC000_20RXH:apndC000DY23�j(���_����Ď��v���Z�X��~)
        echo "apfwC000_20RXH - apndC000DY23�F���_����Ď��v���Z�X��~����SKIP�w��E�E�E"                                    >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_netskip -d${SJ_PEX_DATE} -FapfwC000_20RXH -NapndC000DY23                              >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_20RXH�t���[��apndC000DY23��NETSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi
    fi

    #�uapfwuuuu_10RXH�v�y�j����Еʃt���[�����o�͂���Ă��邩����
    echo "�y�j��Еʃt���[���̃f�t�H���gSKIP�w�菈���J�n�E�E�E"                                                             >> ${DR_LOGFILE}
    for TS_USER_CD in `cat ${APL_DATEFILE_DIR}/USCOM_KIBO_L_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_M_RX.dat ${APL_DATEFILE_DIR}/USCOM_KIBO_S_RX.dat |grep -v '4999'`
    do
        echo "��ЋK�̓t�@�C������擾������ЃR�[�h�F"${TS_USER_CD}                                                        >> ${DR_LOGFILE}
        grep -l "apfw"${TS_USER_CD}"_10RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                       >> ${DR_LOGFILE}
        if [ "$?" = "0" ];then

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwuuuu_10RXH:apjmC000DY13�j(�i���Ǘ��f�[�^�폜[��Е�])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY13:�i���Ǘ��f�[�^�폜����SKIP�w��E�E�E"             >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY13    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXH�t���[��apjmC000DY13��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwuuuu_10RXH:apjmC000DY54�j(�����E�בփo�b�N�A�b�v�擾[��Е�])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY54:�����E�בփo�b�N�A�b�v�擾����SKIP�w��E�E�E"     >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY54    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXH�t���[��apjmC000DY54��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwuuuu_10RXH:apjmC000DY55�j(�����E�בփo�b�N�A�b�v�z�M[��Е�])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY55:�����E�בփo�b�N�A�b�v�z�M����SKIP�w��E�E�E"     >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY55    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXH�t���[��apjmC000DY55��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwuuuu_10RXH:apjmC000DY50�j(�Ɩ��f�[�^�폜[��Е�])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY50:�Ɩ��f�[�^�폜����SKIP�w��E�E�E"                 >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY50    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXH�t���[��apjmC000DY50��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi

            #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwuuuu_10RXH:apjmC000DY17�j(�p�[�e�B�V�����폜[��Е�])
            echo "apfw"${TS_USER_CD}"_10RXH - apnwC000DY10 - apjmC000DY17:�p�[�e�B�V�����폜����SKIP�w��E�E�E"             >> ${DR_LOGFILE}
            sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -Fapfw${TS_USER_CD}_10RXH -NapnwC000DY10 apjmC000DY17    >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                DR_EXEC_STATUS=16
                DR_EXEC_SAT=1
                echo "apfw"${TS_USER_CD}"_10RXH�t���[��apjmC000DY17��JOBSKIP�ݒ�G���["                                     >> ${DR_LOGFILE}
            fi
        else
            echo "�y�j��Еʃt���[��apfw"${TS_USER_CD}"_10RXH�͓����ΏۊO"                                                  >> ${DR_LOGFILE}
        fi
    done

    #�uapfwC000_21RXH�v���o�͂���Ă��邩����
    grep -l "apfwC000_21RXH" ${DR_GEN_CHECK_DIR}/*.txt                                                                      >> ${DR_LOGFILE}
    if [ "$?" = "0" ];then

        #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwC000_21RXH:apjmC000DY54�j(�����E�בփo�b�N�A�b�v�擾[����])
        echo "apfwC000_21RXH - apjmC000DY54:�����E�בփo�b�N�A�b�v�擾����([����])SKIP�w��E�E�E"                           >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjmC000DY54               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXH�t���[��apjmC000DY54��JOBSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi

        #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwC000_21RXH:apjmC000DY50�j(�Ɩ��f�[�^�폜[����])
        echo "apfwC000_21RXH - apjmC000DY50:�Ɩ��f�[�^�폜����([����])SKIP�w��E�E�E"                                       >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjmC000DY50               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXH�t���[��apjmC000DY50��JOBSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi

        #�W���u��P�ƂŃX�L�b�v�ɐݒ�iapfwC000_21RXH:apjwC000DY14�j(DB�T�[�o�̈�̍œK������[����])
        echo "apfwC000_21RXH - apjwC000DY14:DB�T�[�o�̈�̍œK������[����]SKIP�w��E�E�E"                                   >> ${DR_LOGFILE}
        sj_rex ${DR_SHL_SERVER} sjPEX_jobskip -d${SJ_PEX_DATE} -FapfwC000_21RXH -NapfwC000_21RXH apjwC000DY14               >> ${DR_LOGFILE}

        TS_STATUS=$?
        if [ "${TS_STATUS}" != "0" ]; then
            DR_EXEC_STATUS=16
            DR_EXEC_SAT=1
            echo "apfwC000_21RXH�t���[��apjwC000DY14��JOBSKIP�ݒ�G���["                                                    >> ${DR_LOGFILE}
        fi
    fi

fi

TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                             >> ${DR_LOGFILE}
BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                                   >> ${DR_LOGFILE}

#-------------------------------------------------------------------------------------------------------------
# �X�e�b�v-0040 ��SKIP�ݒ菈��
#-------------------------------------------------------------------------------------------------------------
if [ "${DR_EXEC_STATUS}" != "16" ]; then
    TS_STEPID=0040
    BCZC1100.sh ${TS_STEPID}                                                                                                >> ${DR_LOGFILE}

    #�W���uSKIP�R�}���h�t�@�C�������݂��邩�`�F�b�N����
    if [ -f ${DR_SKIPFILE} ]; then

        #�W���uSKIP�R�}���h�t�@�C�����P�s���ǂݍ���
        while read DR_SKIPCMD
        do
            #�擾�����R�}���h�𔭍s
            ${DR_SKIPCMD}                                                                                                   >> ${DR_LOGFILE}

            TS_STATUS=$?
            if [ "${TS_STATUS}" != "0" ]; then
                echo "JOBSKIP�ݒ�G���[ "${DR_SKIPCMD}                                                                      >> ${DR_LOGFILE}
                DR_EXEC_STATUS=16
            fi

        done < ${DR_SKIPFILE}

    else
        echo "��SKIP�ݒ�̕K�v������W���u�͑��݂��܂���"                                                                 >> ${DR_LOGFILE}
    fi

    TS_STEP_RCODE=${DR_EXEC_STATUS}                                                                                         >> ${DR_LOGFILE}
    BCZC1199.sh ${TS_STEPID} ${TS_STEP_RCODE}                                                                               >> ${DR_LOGFILE}
fi

#-------------------------------------------------------------------------------------------------------------
# �I������
#-------------------------------------------------------------------------------------------------------------
if [ "${DR_EXEC_STATUS}" = "0" ];then
    TS_RCODE=0
else
    TS_RCODE=1
fi

BCZC9999.sh ${TS_RCODE}                                                                                                     >> ${DR_LOGFILE}
exit ${TS_RCODE}
