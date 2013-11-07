#!/bin/bash
#    Copyright (C) 2013 Thomas Carette


if [ "$( type -t rhfsA )" == "" ]
then
	echo "WARNING: anaGrasp_func.sh not loaded"
	echo "press enter to load it or Ctrl-C to cancel"
	read
	source $(which anaGrasp_func.sh)
fi
if [ "$( type -t hfsA )" == "" ]
then
	echo "WARNING: anaAtsp2k_func.sh not loaded"
	echo "press enter to load it or Ctrl-C to cancel"
	read 
	source $(which anaAtsp2k_func.sh)
fi

DrhfsA ()
{
	if [ -e $1.ch ]
	then
		if [ -e $4.h ]
		then
			local str=$( echo "$( rhfsA $1 $2 $3 )0 - ($( hfsA $4 $5 )0)" | bc -l )
		fi
	fi
	check $str
}
DrhfsB ()
{
	if [ -e $1.ch ]
	then
		if [ -e $4.h ]
		then
			local str=$( echo "$( rhfsB $1 $2 $3 )0 - ($( hfsB $4 $5 )0)" | bc -l )
		fi
	fi
	check $str
}
Drsmsp ()
{
	if [ -e $1.ci ]
	then
		if [ -e $4.s ]
		then
			local str=$( echo "$( rsmsp $1 $2 $3 )0 - ($( smsp $4 )0)" | bc -l )
		fi
	fi
	check $str
}
