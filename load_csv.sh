#! /usr/bin/sh

readonly data_gen="data_gen.sql"

declare -a regex=(
	[0]="[[:punct:]]"
	[1]="[[:blank:]]"
)

declare -A sql_cred=(
	["db"]="$1"
	["user"]="$2"
	["pass"]="$3"
)


function sql_exp {
echo"LOAD DATA INFILE $1
INTO TABLE $2
FIELDS TERMINATED BY $3
ENCLOSED BY $4
LINES TERMINATED BY $5
IGNORE 1 ROWS;"
}


function read_csv_header {
	echo "$(head -n 1 $1)"
}


function if_blank {
	[[ -n "$1" ]] && echo "blank header" && exit 0;
}


function find_delimiter {
	return  [[ "$1" ~= $2 ]]
}


function gen_data_from_csv {
	
}


function file_write {
	echo "$1" >> "$2"
}


function format_as_header {
	header=""
	for i in "$@"
	do
		header="$header$delimiter$i"
	done
	echo "$header"
}


function iterate_csv {
	for f in *.csv
	do
		echo "$f"
	done
}


function log_with_pass {
	[[ -z "$2" ]] && echo "-p $2"
}



if [[ $# < 2]] || [[$# > 3 ]] then
	echo "wrong args num"
	exit 0;
fi


eval "mysql -u $USER $(log_with_pass $2)"


#iterate_csv | sql_import $USER $DB | csv_write | gen_data | format_as_header
csv_write | gen_data | format_as_header


exit 0;
