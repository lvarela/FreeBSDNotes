use_template() {
  eval "echo \"$(cat $1)\""
}

#$1= question $2=command to run
ask() {
 while true; do
    read -p "$1 [y/n]?" yn
    case $yn in
        [Yy]* ) eval "$2"; break;;
        [Nn]* ) break;;
    * ) echo "Please answer [y]es or [n]o.";;
    esac
done
}

#get the name of the first pool
zpool() {
  return $(zpool list -H -o name | head -1)
}

# Display disc use 
#$1 = jail name
du() {
  du -sh /usr/local/jails/$1	
}

