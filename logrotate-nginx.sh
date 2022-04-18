#!/bin/bash
logroot="/data/logfile/"
loglimit=5
find ${logroot} -mtime +${loglimit} -type f -name "*" -exec rm -f {} \;
for logdir in `ls -F ${logroot} | grep "/$"`
	do 
	echo ${logroot}${logdir}
	cp ${logroot}${logdir}access.log ${logroot}${logdir}access-$(date -d "yesterday" +"%Y%m%d").log
	cp ${logroot}${logdir}error.log ${logroot}${logdir}error-$(date -d "yesterday" +"%Y%m%d").log
done
if [ -f /var/run/nginx.pid ]; then
kill -USR1 `cat /var/run/nginx.pid`
fi

#0 0 * * * /usr/local/bin/logrotate-nginx.sh > /dev/null 2>&1
