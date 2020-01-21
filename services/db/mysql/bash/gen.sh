#! /usr/bin/sh

pool="qwertyuiopasdfghjklzxcvbnm"
comma=";"
db="bank"
log_file="log.txt"

function gen_numeric {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args"
	echo "$(( ( $RANDOM % $1 ) + 1 ))"
}


function gen_alfa {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args"
	ofset="$(( $1 % ${#pool} ))"
	echo "${pool:RANDOM%${#pool}:$ofset}"
}


function gen_card_line {
	expiration_date="$(gen_numeric 2020)-$(gen_numeric 12)-$(gen_numeric 31)"
	user_id="$(gen_numeric 1000)"
	cvv="$(gen_numeric 999)"
	echo "$1;${user_id};${cvv};${expiration_date};"
}


function gen_owner_line {
	reg_date="$(gen_numeric 2020)-$(gen_numeric 12)-$(gen_numeric 31)"
	name="$(gen_alfa 5)"
	family="$(gen_alfa 10)"
	echo "$1;${name};${family};${reg_date};"
}


function logging {
	echo "$1"
	! [[ -f "$log_file" ]] && touch $log_file
	if [[ $(cat $log_file | wc -l) -gt 1 ]]
	then
		echo "$1" > $log_file
	else
		echo "$1" >> $log_file
	fi
}


if [[ "$1" -eq "-r" ]]
then
	for file in csv/*.csv
		do	
			head -n 1 $file > $file
		done

	for id in {0..1000}
		do
			echo "$(gen_card_line $id)" >> "csv/card.csv"
		done

	for id in {0..1000}
		do
			echo "$(gen_owner_line $id)" >> "csv/owner.csv"
		done

	for query in $(ls migration/v[0-9]/*.sql | sort)
		do
			logging "$(mysql -u $USER < $query)"

		done

elif [[ "$1" -eq "-s" ]]
then
	for script in scripts/*.sql
		do
			if [[ -z $script ]]
			then
				logging "$(mysql -u $USER < $query $db)"
			fi
		done
fi

exit 0;
