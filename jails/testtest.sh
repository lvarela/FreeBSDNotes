
#get a list of zpools and add it to an array
#to be selected by the user (IFS is a bash separator)
#IFS=$'\n'
zpool=($(zpool list -H -o name))

#echo ${zpool[@]}

function dialog_select()
{
    local -n arr=$3
#    echo ${arr[@]}

dialog --clear \
    --backtitle "$1" \
    --no-items \
    --menu "$2" 10 40 ${#arr[@]} ${arr[@]} \
    --output-fd 1 > /tmp/jms-res.temp   
}
dialog_select "Jails" "Select a zpool:" zpool 

res=$(cat /tmp/jms-res.temp)
echo "$res"

