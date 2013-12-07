# Backup to WebDav
Script for backup some folder of your project to WebDav.

#### Run
``./backup``

#### Configuration
  * install [cadaver](http://www.webdav.org/cadaver/)
  * create directory on your WebDav server
  * write `~/.netrc` config file for autologin
  * write `.backuprc`
  	* HOST – host, where to connect
  	* BACKUP_DIR – local folder you want to back up
  	* DESTINATION_DIR – remote folder in which you want to back up
  	* IGNORE_CONFIG – optional config with ignores

#### Config's examples	

###### ~/.netrc
```
machine     webdav.yandex.ru
login       login
password    *******

```

###### .backuprc
```
HOST="https://webdav.yandex.ru"
BACKUP_DIR="data"
DESTINATION_DIR="example"
IGNORE_CONFIG=".backupignore"

```

###### .backupignore
```
**/.DS_Store
tmp
```
