# Jail scripts

## Create jails using only the standard FreeBSD jail tools

### jail-init.sh [release zfs-root]
Create a jail enviroment 
 * ZFS pool
 * downloads release 
 * creates an initial jail.conf

  Example: ./jail-init.sh 11.0-RELEASE zroot


### jail-create.sh [jailname interface ip]
Create a jail 
  * ZFS pool
  * Selective ports tree and lib32 creation
  * Creates jail.conf entry
  * starts the jail and shell (if wanted)
  
  Example: ./jail-create.sh webapp1 lo1 10.0.0.1
