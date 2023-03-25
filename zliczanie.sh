grep "OK" cdlinux.ftp.log |cut -d'"' -f2,4 |sort -u |grep -o "cdlinux-.*" |grep "iso$" |sort >test.txt
grep " 200 " cdlinux.www.log |cut -d'"' -f1,2|cut -d" " -f1,7|cut -d":" -f2|sort -u|grep "iso$"|grep -o "cdlinux-.*" |sort >>test.txt
cat test.txt| sort|uniq -c
