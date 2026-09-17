script_path="$(cd "$(dirname "$0")" && cd .. && pwd)"
host_path=$script_path/hosts.ini
mode="$(echo $1 | tr '[:upper:]' '[:lower:]')"

if [[ $mode == "host" ]]; then
    output_path=$script_path/host_vars
    grep_select="-v"
elif [[ $mode == "group" ]]; then
    output_path=$script_path/group_vars
    grep_select=""
else
    exit
fi

host_group_data=$(cat $host_path | grep $grep_select "\[*\]" | tr -d '"[]' )

for item in $host_group_data; do
    touch $output_path/$item.yml
done

check_host=$(ls $output_path/ | sed "s/.yml//g")
 
delete_host=$(echo ${host_group_data[@]} ${check_host[@]} | tr ' ' '\n' | sort | uniq -u)

for item in $delete_host; do
    rm $output_path/$item.yml
done
