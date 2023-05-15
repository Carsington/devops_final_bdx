hostnamectl set-hostname oracle-02.centlinux.com
echo "192.168.186.165 oracle-02.centlinux.com oracle-02" >> /etc/hosts
nmcli dev
sudo nmcli connection add con-name hostonly ifname ens192 type ethernet autoconnect yes
sudo nmcli connection add con-name nat ifname ens160 type ethernet autoconnect yes
nmcli dev
su -
dnf makecache
dnf update -y
reboot
cat /etc/rocky-release
uname -r
cat /sys/kernel/mm/transparent_hugepage/enabled
su -
vi /etc/default/grub # Ajouter transparent_hugepage=never
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
cat /sys/kernel/mm/transparent_hugepage/enabled
su -

dnf install -y  \
bc \
binutils \
compat-openssl10 \
elfutils-libelf \
glibc \
glibc-devel \
ksh \
libaio \
libXrender \
libX11 \
libXau \
libXi \
libXtst \
libgcc \
libnsl \
libstdc++ \
libxcb \
libibverbs \
make \
policycoreutils \
policycoreutils-python-utils \
smartmontools \
sysstat \
libnsl2 \
net-tools \
nfs-utils \
unzip


vi /etc/security/limits.d/30-oracle.conf
/*
oracle   soft   nofile   1024
oracle   hard   nofile   65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock  134217728
oracle   soft   memlock  134217728
oracle   soft   data     unlimited
oracle   hard   data     unlimited
*/

vi /etc/sysctl.d/98-oracle.conf
*/
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
/*
sysctl -p
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
setenforce permissive
firewall-cmd --permanent --add-port=1521/tcp
firewall-cmd --reload
mkdir -p /u01/app/oracle/product/19.3.0/dbhome_1
mkdir -p /u02/oradata
chown -R oracle:oinstall /u01 /u02
chmod -R 775 /u01 /u02
su - oracle
vi ~/.bash_profile
*/
# Oracle Settings
export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=oracle-02.centlinux.com
export ORACLE_UNQNAME=cdb1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.3.0/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_SID=cdb1
export PDB_NAME=pdb1
export DATA_DIR=/u02/oradata

export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
*/
source ~/.bash_profile
cp /tmp/LINUX.X64_193000_db_home.zip .
unzip LINUX.X64_193000_db_home.zip -d $ORACLE_HOME
