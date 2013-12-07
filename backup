#! /bin/bash
#! /usr/bin/expect -f

# checking for cadaver
if [ -z `which cadaver` ]; then
    echo "For backup, you must install \"cadaver\".";
    exit;
fi

# configuration
source ".backuprc";
[ -f $IGNORE_CONFIG ] && BACKUP_IGNORES="-X $IGNORE_CONFIG" || $BACKUP_IGNORES=""
ARCHIVE_NAME=$(date +"%s").tar.bz2

# console log
LOG() {
    [[ -z $1 ]] && msg="" || msg="===>  $1";
    echo -e "\n$msg"
}


LOG "archiving $ARCHIVE_NAME ..."
tar cjvf $ARCHIVE_NAME $BACKUP_IGNORES $BACKUP_DIR

LOG "backup to webdav ..."
expect -c "
spawn cadaver -t $HOST/$DESTINATION_DIR
expect \"Do you wish to accept the certificate\"
send \"y\n\"
expect \"dav:\"
send \"delete *.tar.bz2\n\"
expect \"dav:\"
send \"put $ARCHIVE_NAME $ARCHIVE_NAME\n\"
expect \"dav:\"
exit"

[ -f $ARCHIVE_NAME ] && rm $ARCHIVE_NAME

LOG
LOG "backup $ARCHIVE_NAME complete."
