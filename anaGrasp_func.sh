#!/bin/bash
#    Copyright (C) 2013 Thomas Carette
source $(which anaCommon.sh)

inp ()
{
	echo $1
}

compF ()
{
if [ "$1" != "" ]
then
  echo "${1}*2.34965/3*29*2*3.1416" | sed -e 's/[D]+*/\*10\^/' |  bc -l
fi
}

CONVstart ()
{
if [ -e $1.sc ]
then
  if $( grep "; this fails the\|Iteration" $1.sc | tail -1 | grep -q fails )
  then
     local str=$( grep -B1 "; this fails the\|Iteration" $1.sc | tail -2 | grep -B1 fails | head -1)
     orb=$( echo $str | awk '{print $2}' )
     local str=$( echo $str | awk '{print $5}' )
     echo "${orb}:$str"
  else
     echo "OK?"
  fi
else echo '     -     '
fi
}

CONVnorm ()
{
if [ -e $1.sc ]
then
  local str=$( grep -n "^Subshell" $1.sc | tail -1 )
  local local n=$(( ${str%:*} + 2 ))

  local str=$(head -$n $1.sc | tail -1)
  local fstr=$( echo ${str} | gawk '{print $1}' )
  max=0.0

  while [[ ${str:2:2} =~ [0-9][s,p,d,f,g,h,i,k,l,m,n] ]] || [[ "${fstr}" == "START:" ]] || [[ "${fstr}" == "E(" ]]
  do
    if [[ "${fstr}" == "START:" ]]
    then
      local local n=$(( n+3 ))
      if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi
      local str=$(head -$n $1.sc | tail -1)
      local fstr=$( echo ${str} | gawk '{print $1}' )
      continue
    fi
    if [[ "${fstr}" == "E(" ]]
    then
      local local n=$(( n+1 ))
      if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi
      local str=$(head -$n $1.sc | tail -1)
      local fstr=$( echo ${str} | gawk '{print $1}' )
      continue
    fi
    new=$( echo $str | sed -e 's/[D]+*/\*10\^/g' | gawk '{ if($6>=0) {print $6} else {print "-("$6")" }}' | bc -l )

#echo $new $max  $(echo "$new > $max" | bc -l )
    if (( $(echo "$new > $max" | bc -l ) ))
    then
      orb=$( echo $str | awk '{print $1}' )
      max=$new 
    fi

    local local n=$(( n+1))
    if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi
    local str=$(head -$n $1.sc | tail -1)
    local fstr=$( echo ${str} | gawk '{print $1}' )
  done
  local num=$(echo $max | gawk '{print $1*1}')
  echo $orb:$num
else echo '     -     '
fi
}

CONVdpm ()
{
if [ -e $1.sc ]
then
  local str=$( grep -n "^Subshell" $1.sc | tail -1 )
  local local n=$(( ${str%:*} + 2 ))

  local str=$(head -$n $1.sc | tail -1)
  max=0.0

  while [[ ${str:2:2} =~ [0-9][s,p,d,f,g,h,i,k,l,m,n] ]] || [[ "${fstr}" == "START:" ]] || [[ "${fstr}" == "E(" ]]
  do
    if [[ "${fstr}" == "START:" ]] 
    then
      local local n=$(( n+3 ))
      if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi
      local str=$(head -$n $1.sc | tail -1)
      local fstr=$( echo ${str} | gawk '{print $1}' )
      continue
    fi
    if [[ "${fstr}" == "E(" ]]
    then
      local local n=$(( n+1 ))
      if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi
      local str=$(head -$n $1.sc | tail -1)
      local fstr=$( echo ${str} | gawk '{print $1}' )
      continue
    fi

    new=$( echo $str | sed -e 's/[D]+*/\*10\^/g' | gawk '{ if($5>=0) {print $5} else {print "-("$5")" }}' | bc -l )

#echo $new $max  $(echo "$new > $max" | bc -l )
    if (( $(echo "$new > $max" | bc -l ) ))
    then
      orb=$( echo $str | awk '{print $1}' )
      max=$new
    fi

    local local n=$(( n+1))

    if [ $( wc $1.sc | awk '{print $1}' ) -le $n ];then  break;fi

    local str=$(head -$n $1.sc | tail -1)
    local fstr=$( echo ${str} | gawk '{print $1}' )
  done
  local num=$(echo $max | gawk '{print $1*1}')
  echo $orb:$num
else echo '     -     '
fi
}

ncfg ()
{
if [ -e $1.c ]
then
  tnrcfg $1.c
fi
}

en ()
{
local n=$( inp $3 '.' )
if [ -e $1.sum ]
then
  local str=$( awk '/Eigenenergies:/,/Weights of major contributors to ASF/' $1.sum | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

enc ()
{
local n=$( inp $3 '.' )
if [ -e $1.csum ]
then
  local str=$( awk '/Eigenenergies:/,/Weights of major contributors to ASF/' $1.csum | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

whichmain ()
{
local n=$( inp $3 '.' )
if [ -e $1.sum ]
then
  local str=$( awk '/Weights of major contributors to ASF/,0' $1.sum | grep "^ *$n *$2 *[-,+]\?" | head -2 | tail -1 | gawk '{ print $1 }' )
fi
check $str
}

mainconf ()
{
local n=$( inp $3 '.' )
if [ -e $1.sum ]
then
  local str=$( awk '/  CSF contributions/,0' $1.sum | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $5 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

rhfsA ()
{
local n=$( inp $3 '.' )
if [ -e $1.ch ]
then
  local str=$( grep -A50 "Interaction constants" $1.ch | grep "^ *$n *$2 [+,-]\?" | tail -1 | gawk '{ print $4 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

rhfsB ()
{
local n=$( inp $3 '.' )
if [ -e $1.ch ]
then
  local str=$( grep -A50 "Interaction constants" $1.ch | grep "^ *$n *$2 [-,+]\?" | tail -1 | gawk '{ print $5 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

pipj ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Specific mass shift/,/Electron density in atomic units/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$( compM $str)
fi
check $str
}

rsmsp ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Specific mass shift/,/Electron density in atomic units/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $6 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}


smsK ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Specific mass shift/,/Electron density in atomic units/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $6 }' )
  local str=$( compM $str)
fi
check $str
}

nmsK ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Normal mass shift/,/Specific mass shift/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $6 }' )
  local str=$( compM $str)
fi
check $str
}

pi2 ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Normal mass shift/,/Specific mass shift/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$( compM $str)
fi
check $str
}

T ()
{
local n=$( inp $3 '.' )
if [ -e $1.sms ]
then
  local str=$( awk '/T \(a.u.\)/,/Radial expectationvalue/' $1.sms | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$( compM $str)
fi
check $str
}

msK ()
{
a=$( nmsK "$1" "$2" "$3" )
b=$( smsK "$1" "$2" "$3" )
if $( isnumber $a $b )
then
  local str=$(echo "$a + $b" | bc -l)
fi
check $str
}

nrmsK ()
{
a=$( pi2 "$1" "$2" "$3" ) 
b=$( pipj "$1" "$2" "$3" ) 
if $( isnumber $a $b )
then
  local str=$(echo "$a + $b" | bc -l)
fi
check $str
}

RCImsK ()
{
a=$( T "$1" "$2" "$3" ) 
b=$( pipj "$1" "$2" "$3" ) 
if $( isnumber $a $b )
then
  local str=$(echo "$a + $b" | bc -l)
fi
check $str
}

dens ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Electron density in atomic units/,/Radial expectationvalue/'  $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$(echo "${str}" | sed -e 's/[D]+*/\*10\^/' |  bc -l)
fi
check $str
}

F ()
{
local n=$( inp $3 '.' )
if [ -e $1.ci ]
then
  local str=$( awk '/Electron density in atomic units/,/Radial expectationvalue/' $1.ci | grep "^ *$n *$2 [-,+]\?" | head -1 | gawk '{ print $4 }' )
  local str=$( compF $str )
fi
check $str
}
###################

Dencmk ()
{
a=$( enc "$1" "$2" "$3" )
b=$( enc "$4" "$5" "$6" )
if $( isnumber $a $b )
then
  local str=$(echo "219474.63*($a - $b)" | bc -l)
fi
check $str
}

Dencmkc ()
{
a=$( enc "$1" "$2" "$3")
b=$( enc "$4" "$5" "$6")
if $( isnumber $a $b )
then
  local str=$(echo "219474.63*($a - $b)" | bc -l)
fi
check $str
}


for f in en enc nrmsK msK nmsK pipj pi2 smsK dens T RCImsK F smsSL
do

eval "D$f ()
{
a=\$( $f \$1 \"\$2\" \$3 )
b=\$( $f \$4 \"\$5\" \$6 )
if \$( isnumber \$a \$b )
then
  local str=\$(echo \$a - \$b | bc -l)
fi
echo \$( check \$str )
}"

done

DsmsSL ()
{
a=$( DmsK $1 "$2" $3 $4 "$5" $6 )
#b=$( enc $1 "$2" $3 $4 "$5" $6 )
if $( isnumber $a ) # $b )
then
#  b=$( compM $b )
#  local str=$(echo "$a + ($b)" | bc -l)
  local str=$(echo "$a + 506.27615765283109" | bc -l)
fi
check $str
}



