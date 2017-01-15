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

# Display disc use 
#$1 = jail name
du() {
  du -sh /usr/local/jails/$1	
}

# args: backtitle menu-text array with items
function dialog_select()
{
    local -n arr=$3

  dialog --clear \
    --backtitle "$1" \
    --no-items \
    --menu "$2" 10 40 ${#arr[@]} ${arr[@]} \
    --output-fd 1 > /tmp/jms-res.temp   
}
