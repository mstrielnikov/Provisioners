#! /usr/bin/sh

pool="qwertyuiopasdfghjklzxcvbnm"
comma=";"
db="bank"

function gen_numeric {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args" 
	echo "$(($RANDOM % $1 + 1))"
#	echo ${str:0:$1}
}


function as_date {
	! [[ $# -eq 3 ]] && echo "${FUNCNAME[0]}: wrong args"
	yyyy="$1"
	mm="$2"
	dd="$3"
	echo "$yyyy-$mm-$dd"
}


function gen_alfa {
	! [[ $# -eq 1 ]] && echo "${FUNCNAME[0]}: wrong args"
	ofset="$(($1 % ${#pool}))"
	echo "${pool:RANDOM%${#pool}:$ofset}"
#	echo "${str}"
}


function gen_card_line {
	local date
	date=("$(gen_numeric 2019)" "$(gen_numeric 12)" "$(gen_numeric 31)")
	expiration_date="$(as_date ${date[@]})"

	user_id="$(gen_numeric 1000)"
	cvv="$(gen_numeric 999)"

	echo "$1;$user_id;$cvv;$expiration_date"

#	data=("$1" "$user_id" "$cvv" "$expiration_date")
#	(IFS="$2"; echo "${data[*]}")
}


function gen_owner_line {
	local date
	date=("$(gen_numeric 2019)" "$(gen_numeric 12)" "$(gen_numeric 31)")
	reg_date="$(as_date ${date[@]})"

	name="$(gen_alfa 5)"
	family="$(gen_alfa 10)"

	echo "$1;$name;$family;$reg_date"

#	data=("$1" "$name" "$family" "$reg_date")
#	(IFS="$2"; echo "${data[*]}")
}

if [[ "$1" -eq "-r" ]]
then
	for file in csv/*.csv
		do	
			head -n 1 $file > $file
		done
fi
#for file in *.csv
#do
for id in {0..1000}
	do
		gen_card_line $id >> "csv/card.csv"
	done
#done

for id in {0..1000}
	do
		gen_owner_line $id >> "csv/owner.csv"
	done

for t in sql/*.sql
do
	mysql -u $USER < $t
done
#mysql -u $USER < sql/load_card.sql

exit 0;
