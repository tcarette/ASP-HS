#!/bin/bash
#    Copyright (C) 2013 Thomas Carette
source $(which anaCommon.sh)

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
			local a=$( rhfsA $1 $2 $3 )
			local b=$( hfsA $4 $5 )
			if $(isnumber $a $b)
			then
				local str=$( echo "$a - ($b)" | bc -l )
			fi
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
			local a=$( rhfsB $1 $2 $3 )
			local b=$( hfsB $4 $5 )
			if $(isnumber $a $b)
			then
				local str=$( echo "$a - ($b)" | bc -l )
			fi
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
			local a=$( rsmsp $1 $2 $3 )
			local b=$( smsp $4 $5 )
			if $(isnumber $a $b)
			then
				local str=$( echo "$a -($b)" | bc -l )
			fi
		fi
	fi
	check $str
}
