# Executer ses commande dans Rocky
su -
nmcli dev
sudo nmcli connection add con-name hostonly ifname ens192 type ethernet autoconnect yes
sudo nmcli connection add con-name nat ifname ens160 type ethernet autoconnect yes
nmcli dev
ip a
# Aller dans moba
su -
hostnamectl set-hostname oracledb19col8.rishoradev.com
echo "192.168.186.170 oracledb19col8.rishoradev.com oracledb19col8" >> /etc/hosts
ifconfig
hostname
cp /tmp/oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm .
dnf install -y oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm
yum update -y --skip-broken 
vi /etc/selinux/config # SELINUX=permissive
systemctl stop firewalld
systemctl disable firewalld
passwd oracle
su - oracle
mkdir -p /home/oracle/u01/app/oracle/product/19c/dbhome_1
mkdir -p /home/oracle/u02/oradata
chown -R oracle:oinstall /home/oracle/u01 /home/oracle/u02
chmod -R 777 /home/oracle/u01 /home/oracle/u02
mkdir scripts
cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=oracledb19col8.rishoradev.com
export ORACLE_UNQNAME=cdb1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/19c/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_SID=cdb1
export PDB_NAME=pdb1
export DATA_DIR=/u02/oradata

export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
EOF
echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile
cd u01/app/oracle/product/19c/dbhome_1/
cp /tmp/LINUX.X64_193000_db_home.zip .
ls -lrt
unzip -q LINUX.X64_193000_db_home.zip
ls
./runInstaller
export CV_ASSUME_DISTID=OEL7.6
./runInstaller
cd /home/oracle/u01/app/oraInventory/
./orainstRoot.sh
cd oracle/product/19c/dbhome_1/
./root.sh
cd
lsnrctl start
dbca -silent -createDatabase                                                   \
     -templateName General_Purpose.dbc                                         \
     -gdbname ${ORACLE_SID} -sid  ${ORACLE_SID} -responseFile NO_VALUE         \
     -characterSet AL32UTF8                                                    \
     -sysPassword Welcome1                                                 \
     -systemPassword Welcome1                                              \
     -createAsContainerDatabase true                                           \
     -numberOfPDBs 1                                                           \
     -pdbName ${PDB_NAME}                                                      \
     -pdbAdminPassword Welcome1                                            \
     -databaseType MULTIPURPOSE                                                \
     -memoryMgmtType auto_sga                                                  \
     -totalMemory 2000                                                         \
     -storageType FS                                                           \
     -datafileDestination "${DATA_DIR}"                                        \
     -redoLogFileSize 50                                                       \
     -emConfiguration NONE                                                     \
     -ignorePreReqs

sqlplus / as sysdba
Select BANNER_FULL from v$version;
[13:16]
cat > /home/oracle/scripts/start_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh
export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES
dbstart $ORACLE_HOME
EOF
[13:17]
cat > /home/oracle/scripts/stop_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh
export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES
dbshut $ORACLE_HOME
EOF
[13:17]
chown -R oracle:oinstall /home/oracle/scripts
chmod u+x /home/oracle/scripts/*.sh
sqlplus / as sysdba <<EOF
alter system set db_create_file_dest='${DATA_DIR}';
alter pluggable database ${PDB_NAME} save state;
exit;
EOF
su -
dnf install git
su - oracle
git clone -b ora-nodocker https://github.com/matthcol/dbmovie
cd dbmovie/sql
sqlplus / as sysdba
alter session set "_ORACLE_SCRIPT"=true;
@00-user.sql
sqlplus movie/password @ movie_all.sql

