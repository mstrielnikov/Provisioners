#! /usr/bin/sh

pool="qwertyuiopasdfghjklzxcvbnm"
comma=";"
db="bank"

function gen_numeric {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args" 
	RANDOM=0
	echo "$(( ( $RANDOM % $1 ) + 1 ))"
}


function gen_alfa {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args"
	ofset="$(( $1 % ${#pool} ))"
	echo "${pool:RANDOM%${#pool}:$ofset}"
}


function gen_card_line {
	expiration_date="$(gen_numeric 2019)-$(gen_numeric 12)-$(gen_numeric 31)"
	user_id="$(gen_numeric 1000)"
	cvv="$(gen_numeric 999)"
	echo "$1;$user_id;$cvv;$expiration_date"
}


function gen_owner_line {
	reg_date="$(gen_numeric 2019)-$(gen_numeric 12)-$(gen_numeric 31)"
	name="$(gen_alfa 5)"
	family="$(gen_alfa 10)"
	echo "$1;$name;$family;$reg_date"
}


if [[ "$1" -eq "-r" ]]
then
	for file in csv/*.csv
		do	
			head -n 1 $file > $file
		done
fi

for id in {0..1000}
	do
		gen_card_line $id >> "csv/card.csv"
	done

for id in {0..1000}
	do
		gen_owner_line $id >> "csv/owner.csv"
	done

for query in $(ls migration/v[0-9]/*.sql | sort)
	do
		mysql -u $USER < $query
	done

exit 0;
