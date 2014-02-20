#!/bin/bash
#    Copyright (C) 2013 Thomas Carette

check ()
{
if [ "$1" == "" ]
then
  echo " -- "
else
  printf "%f16" $1
fi
}

isnumber ()
{
ok=0
for i in "$@"
do  if ! [[ "$i" =~ ^[-]?[0-9]+?([.][0-9]+)?$ ]]
  then
    ok=1
    break
  fi
done
return $ok
}

compM ()
{
if [ "$1" != "" ]
then
  echo "${1}*3609.48" | sed -e 's/[D]+*/\*10\^/' |  bc -l
#  echo "${1}          " | sed -e 's/[D]+*/\*10\^/' |  bc -l
fi
}

ncfg ()
{
if [ -e $1.c ]
then
	if $(grep -q "Core" $1)
	then
		local str=$(nrcfg_bl $1.c "$2")
	else
		local str=$(nrcfg $1.c)
	fi
fi
if [[ "$str" =~ ^[0-9]+$ ]]
then
  echo $str
else
	echo "--"
fi
}
