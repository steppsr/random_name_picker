#!/bin/bash

usage () {
    echo "random_name_picker.sh is a script that will select 1 or 2 word names from files."
    echo ""
	echo "USAGE: bash random_name_picker.sh [OPTIONS]"
	echo ""
	echo "  OPTIONS"
	echo "   -u          Force names to be unique."
	echo "   -i INTEGER  Number of names to create."
	echo "   -f1 FILE    File containing first names. File must have one per line and no blank lines."
	echo "   -f2 FILE    File containing last names. File must have one per line and no blank lines."
	echo "   -h          Help"
    echo "   -v          Current version & version history."
	echo ""
	echo "   Example:"
	echo "      bash random_name_picker.sh -u -i 10 -f1 firstnames.txt -f2 lastnames.txt"
	echo ""
	echo "   Example for saving to file:"
	echo "      bash random_name_picker.sh -u -i 10 -f1 firstnames.txt -f2 lastnames.txt > names_list.txt"
	echo ""
}

version () {
	echo "Current version: 0.1"
	echo ""
	echo "Version 0.1 - Initial version with basic functionality to choose 1 word names, or 2 word names."
	echo "              Name can be unique or allow duplicates."
	echo ""
}

appdir=`pwd`
logfile="$appdir/run.log"

infile1=""
infile2=""
file1=""
file2=""
unique=0
num=0

# Command Line Arguments
while [ -n "$1" ]
do
   case "$1" in
      -f1) infile1=$2 && shift ;;
      -f2) infile2=$2 && shift ;;
      -i) num=$2 && shift ;;
      -u) unique=1 ;;
      -h) usage && exit 1 ;;
      -v) version && exit 1 ;;
      *) ;;
   esac
shift
done

# Import name file
# Sort and print the name arrays to verify you don't have repeats
# Get Number of records in files
if [[ -f "$infile1" ]]; then
   name1=`cat $infile1`
   one=( $( for x in ${name1[@]}; do echo $x; done | sort) )
   file1count=`cat $infile1 | wc -l` && file1count=$(($file1count-1))
else
   echo "ERROR: Could not find file to use for names."
   exit 1
fi
if [[ -f "$infile2" ]]; then
   name2=`cat $infile2`
   two=( $( for x in ${name2[@]}; do echo $x; done | sort) )
   file2count=`cat $infile2 | wc -l` && file2count=$(($file2count-1))
fi

# loop through each file and create metadata file
for (( itm=1; itm<=$num; itm++ ))
do
    if [[ "$unique" -eq "1" ]]; then

        # MUST BE UNIQUE NAMES
	    # generate a new name until we have one that isn't already used.
	    available=0
	    until [[ "$available" -eq "1" ]]; do

	        if [[ -f "$infile2" ]]; then
	           a=`shuf -i 0-$file1count -n1`
	           b=`shuf -i 0-$file2count -n1`
	           katname="${one[a]} ${two[b]}"
	        else
	           a=`shuf -i 0-$file1count -n1`
	           katname="${one[a]}"
	        fi

	        if [[ ! " ${used_names[*]} " =~ " ${katname} " ]]; then
	           available=1
	        fi
	    done
	    used_names+=( "$katname" )
		echo "$katname" | tee -a "$logfile"

    else

        # REPEATS are okay
        if [[ -f "$infile2" ]]; then
           a=`shuf -i 0-$file1count -n1`
           b=`shuf -i 0-$file2count -n1`
           katname="${one[a]} ${two[b]}"
        else
           a=`shuf -i 0-$file1count -n1`
           katname="${one[a]}"
        fi
        echo "$katname" | tee -a "$logfile"
    fi
done
