export APACHE_ROOT=/home/vcap/app/httpd
export INCLUDE_LINE="Include conf.d/*.conf"

mv $APACHE_ROOT/conf/httpd.conf $APACHE_ROOT/conf/httpd.conf.org
erb $APACHE_ROOT/conf/httpd.conf.org > $APACHE_ROOT/conf/httpd.conf

cat $APACHE_ROOT/conf/httpd.conf.org > ./test.conf

# 1. create conf.d directory
# 2. add line to httpd.conf to include conf.d files
# 3. add the modified axm.conf file.
mkdir $APACHE_ROOT/conf.d
echo $INCLUDE_LINE >> $APACHE_ROOT/conf.d/axm.conf

(tail $APACHE_ROOT/logs/*log &)
exec $APACHE_ROOT/bin/httpd -DFOREGROUND
