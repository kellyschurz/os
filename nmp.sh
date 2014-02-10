#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#set the password of mysql
echo "========================================="
mysqlrootpwd="root"
echo "Please input the root password of mysql:"
read -p "(Default password: root):" mysqlrootpwd
if [ "$mysqlrootpwd" = "" ]; then
	mysqlrootpwd="root"
fi
echo mysqlrootpwd="$mysqlrootpwd"
echo "========================================="

cur_dir=$(pwd)

#Set timezone
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

yum install -y ntp
ntpdate -u pool.ntp.org
date

rpm -qa|grep  httpd
rpm -e httpd
rpm -qa|grep mysql
rpm -e mysql
rpm -qa|grep php
rpm -e php

yum -y remove httpd*
yum -y remove php*
yum -y remove mysql-server mysql
yum -y remove php-mysql
yum -y install yum-fastestmirror

#Disable SeLinux
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

for packages in patch make gcc gcc-c++ diffutils gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap pcre pcre-devel python-devel libxml2 libxml2-devel  libxslt libxslt-devel;
do yum -y install $packages; done


echo "============================check files=================================="
if [ -s php-5.4.24.tar.gz ]; then
  echo "php-5.4.24.tar.gz [found]"
  else
  echo "Error: php-5.4.24.tar.gz not found!!!download now......"
  wget -c http://us1.php.net/get/php-5.4.24.tar.gz/from/this/mirror
fi

if [ -s mysql-5.1.68.tar.gz ]; then
  echo "mysql-5.1.66.tar.gz [found]"
  else
  echo "Error: mysql-5.1.68.tar.gz not found!!!download now......"
  wget -c http://cdn.mysql.com/Downloads/MySQL-5.1/mysql-5.1.68.tar.gz
fi

if [ -s nginx-1.2.7.tar.gz ]; then
  echo "nginx-1.2.7.tar.gz [found]"
  else
  echo "Error: nginx-1.2.7.tar.gz not found!!!download now......"
  wget -c http://nginx.org/download/nginx-1.2.7.tar.gz
fi

if [ -s memcache-3.0.6.tgz ]; then
  echo "memcache-3.0.6.tgz [found]"
  else
  echo "Error: memcache-3.0.6.tgz not found!!!download now......"
  wget -c http://pecl.php.net/get/memcache-3.0.6.tgz
fi

if [ -s pcre-8.30.tar.gz ]; then
  echo "pcre-8.30.tar.gz [found]"
  else
  echo "Error: pcre-8.30.tar.gz not found!!!download now......"
  wget -c https://downloads.sourceforge.net/project/pcre/pcre/8.30/pcre-8.30.tar.gz
fi

if [ -s libiconv-1.14.tar.gz ]; then
  echo "libiconv-1.14.tar.gz [found]"
  else
  echo "Error: libiconv-1.14.tar.gz not found!!!download now......"
  wget -c http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
fi

if [ -s libmcrypt-2.5.8.tar.gz ]; then
  echo "libmcrypt-2.5.8.tar.gz [found]"
  else
  echo "Error: libmcrypt-2.5.8.tar.gz not found!!!download now......"
  wget -c  https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
fi

if [ -s mhash-0.9.9.9.tar.gz ]; then
  echo "mhash-0.9.9.9.tar.gz [found]"
  else
  echo "Error: mhash-0.9.9.9.tar.gz not found!!!download now......"
  wget -c https://downloads.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz
fi

if [ -s mcrypt-2.6.8.tar.gz ]; then
  echo "mcrypt-2.6.8.tar.gz [found]"
  else
  echo "Error: mcrypt-2.6.8.tar.gz not found!!!download now......"
  wget -c https://downloads.sourceforge.net/project/mcrypt/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz
fi
if [ -s autoconf-2.69.tar.gz ]; then
  echo "autoconf-2.69.tar.gz [found]"
  else
  echo "Error: autoconf-2.69.tar.gz not found!!!download now......"
  wget -c http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
fi
echo "============================check files=================================="


echo "============================start install================================"
cd $cur_dir
tar zxvf autoconf-2.69.tar.gz
cd autoconf-2.69/
./configure --prefix=/usr/local/autoconf-2.69
make && make install
cd ../

tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14/
./configure --prefix=/usr/local/libiconv
make && make install
cd ../

tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8/
./configure
make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install
cd ../../

tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9/
./configure
make && make install
cd ../

ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1
ln -s /usr/local/bin/libmcrypt-config /usr/bin/libmcrypt-config

tar zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
ldconfig
./configure
make && make install
cd ../

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        ln -s /usr/lib64/libpng.* /usr/lib/
        ln -s /usr/lib64/libjpeg.* /usr/lib/
fi

ulimit -v unlimited

if [ ! `grep -l "/lib"    '/etc/ld.so.conf'` ]; then
	echo "/lib" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib" >> /etc/ld.so.conf
fi

if [ -d "/usr/lib64" ] && [ ! `grep -l '/usr/lib64'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib64" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/local/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/local/lib" >> /etc/ld.so.conf
fi

ldconfig

ulimit -SHn 65535

cat >>/etc/security/limits.conf<<eof
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
eof

cat >>/etc/sysctl.conf<<eof
fs.file-max=65535
eof

#============================================================================================================================
#install mysql 
groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql
cd $cur_dir
tar zxvf mysql-5.1.68.tar.gz
cd mysql-5.1.68/
./configure --prefix=/opt/mysql --with-extra-charsets=complex --enable-thread-safe-client --enable-assembler --with-client-ldflags=-all-static --with-mysqld-ldflags=-all-static --with-charset=utf8 --with-big-tables --with-readline --with-ssl --with-embedded-server --with-unix-socket-path=/tmp/mysql.sock --enable-local-infile --with-plugins=partition,innobase,myisammrg

make && make install
cd ../

chmod +w /opt/mysql
chown -R mysql:mysql /opt/mysql
cp /opt/mysql/share/mysql/my-medium.cnf /etc/my.cnf
#sed -i 's:#innodb:innodb:g' /etc/my.cnf
sed -i 's/skip-locking/skip-external-locking/g' /etc/my.cnf
/opt/mysql/bin/mysql_install_db --user=mysql

cp /opt/mysql/share/mysql/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

cat > /etc/ld.so.conf.d/mysql.conf<<EOF
/opt/mysql/lib/mysql
/usr/local/lib
EOF
ldconfig

ln -s /opt/mysql/lib/mysql /usr/lib/mysql
ln -s /opt/mysql/include/mysql /usr/include/mysql

/etc/init.d/mysql start

ln -s /opt/mysql/bin/mysql /usr/bin/mysql
ln -s /opt/mysql/bin/mysqldump /usr/bin/mysqldump
ln -s /opt/mysql/bin/myisamchk /usr/bin/myisamchk

/opt/mysql/bin/mysqladmin -u root password $mysqlrootpwd

cat > /tmp/mysql.sql<<EOF
use mysql;
update user set password=password('$mysqlrootpwd') where user='root';
delete from user where not (user='root') ;
delete from user where user='root' and password=''; 
drop database test;
DROP USER ''@'%';
flush privileges;
EOF

/opt/mysql/bin/mysql -u root -p$mysqlrootpwd -h localhost < /tmp/mysql.sql

rm -f /tmp/mysql.sql
chkconfig --level 345 mysql on
/etc/init.d/mysql restart
/etc/init.d/mysql stop
echo "============================mysql intall completed========================="

#===============================================================================================
#install php

cd $cur_dir
export PHP_AUTOCONF=/usr/local/autoconf-2.69/bin/autoconf
export PHP_AUTOHEADER=/usr/local/autoconf-2.69/bin/autoheader
tar zxvf php-5.4.24.tar.gz
cd  php-5.4.24
./buildconf --force
./configure --prefix=/opt/php --with-config-file-path=/opt/php/etc --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv=/usr/local/libiconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath    --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --disable-fileinfo --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --enable-fpm
make ZEND_EXTRA_LIBS='-liconv'
make install

cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

cd $cur_dir

tar zxvf memcache-3.0.6.tgz
cd memcache-3.0.6/
/opt/php/bin/phpize
./configure --with-php-config=/opt/php/bin/php-config
make && make install
cd ../

ln -s /opt/php/bin/php /usr/bin/php
ln -s /opt/php/bin/phpize /usr/bin/phpize
ln -s /opt/php/sbin/php-fpm /usr/bin/php-fpm

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
    tar zxvf ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64/php-5.4.x/ZendGuardLoader.so /usr/local/zend/
else
	tar zxvf ZendGuardLoader-70429-PHP-5.4-linux-glibc23-i386.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendGuardLoader-70429-PHP-5.4-linux-glibc23-i386/php-5.4.x/ZendGuardLoader.so /usr/local/zend/
fi
cd $cur_dir

tar zxvf eaccelerator.tar.gz
cd eaccelerator-eaccelerator-42067ac
mkdir -p /tmp/eaccelerator_cache
/opt/php/bin/phpize
./configure --enable-eaccelerator=shared --with-php-config=/opt/php/bin/php-config 
make && make install
cd ../
mkdir -p /opt/php/etc

cp php.ini /opt/php/etc/php.ini
cp php-fpm.conf /opt/php/etc/php-fpm.conf
groupadd www
useradd -s /sbin/nologin -g www www

#install nginx
mkdir -p /opt/wwwroot
chmod +w /opt/wwwroot
mkdir -p /opt/wwwlogs
chmod 777 /opt/wwwlogs

tar zxvf pcre-8.30.tar.gz
cd pcre-8.30/
./configure
make && make install
cd ../

ldconfig

tar zxvf nginx-1.2.7.tar.gz
cd nginx-1.2.7/
./configure --user=www --group=www --prefix=/opt/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
make && make install
cd ../

rm -f /opt/nginx/conf/nginx.conf
cp nginx.conf /opt/nginx/conf/nginx.conf
mkdir -p /opt/nginx/conf/vhost

cp init.d.nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx

chkconfig --level 345 nginx on
chkconfig --level 345 php-fpm on
service mysql start
service php-fpm start
service nginx start



