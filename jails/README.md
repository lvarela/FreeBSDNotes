# Jail scripts

## Create jails using only the standard FreeBSD jail tools

### jail-init.sh
Create a jail enviroment (ZFS pool, downloads release and creates an initial jail.conf)

### jail-create.sh [interface ip]
Create a jail 
  * ZFS pool
  * Selective ports tree and lib32 creation
  * Creates jail.conf entry
  
