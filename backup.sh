#
# Ccopyright (c) 2013 Oleg Apostol
# Script for backup some folder of your project to WebDAV v0.0.1
#
#!/bin/bash
#!/usr/bin/expect -f

# console log
LOG() {
    [ -z "$1" ] && msg="" || msg="===>  $1";
    echo "\n$msg"
}

# checking for cadaver
if [ -z `which cadaver` ]; then
    echo "For backup, you must install \"cadaver\".";
    exit;
fi

# checking for expect
if [ -z `which expect` ]; then
    echo "For backup, you must install \"expect\".";
    exit;
fi

# configuration
. `pwd`/.backuprc
[ -f $IGNORE_CONFIG ] && BACKUP_IGNORES="-X $IGNORE_CONFIG" || $BACKUP_IGNORES=""
ARCHIVE_NAME=$(date +"%s").tar.bz2

LOG "archiving $ARCHIVE_NAME ...";
tar cjvf $ARCHIVE_NAME $BACKUP_IGNORES $BACKUP_DIR

if [ -z $HOST ] && [ -z $DESTINATION_DIR ]; then
    LOG "backup error"
else
    LOG "backup to webdav $HOST/$DESTINATION_DIR ...";
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
    LOG "backup $ARCHIVE_NAME complete.";
fi
