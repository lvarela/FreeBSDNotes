
use_template() {
  eval "echo \"$(cat $1)\""
}

#$1= question $2=command to run
ask() {
 while true; do
    read -p "$1 [y/n]?" yn
    case $yn in
        [Yy]* ) eval "$2"; break;;
        [Nn]* ) exit;;
    * ) echo "Please answer [y]es or [n]o.";;
    esac
done
}
