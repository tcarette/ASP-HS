isnumber ()
{
ok=0
for i in "$@"
do
  if ! [[ "$i" =~ ^[-]?[0-9]+?([.][0-9]+)?$ ]]
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
  echo "${1}*3609.4824" | sed -e 's/[D]+*/\*10\^/' |  bc -l
#  echo "${1}          " | sed -e 's/[D]+*/\*10\^/' |  bc -l
fi
}

check ()
{
if [ "$1" == "" ]
then
 echo " --- "
else
 echo $1
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
fi
check $str
}

ncfg ()
{
if [ -e $1.c ]
then
  local str=$( nrcfg $1.c )
fi
check $str
}

enmchf ()
{
if [ -e $1.s ]
then
  local str=$( tail -4 $1.s | head -1 | gawk '{ print $2 }' )
fi
check $str
}

nms ()
{
if [ -e $1.s ]
then
  local str=$( echo "$( en $1 ) * 0.8474608 * 2.194746313705 / 10" | bc -l )
fi
check $str
}

smsp ()
{
if [ -e $1.s ]
then
  local str=$( grep 'Isotope' $1.s | gawk '{ print $5 }' )
fi
check $str
}

sms ()
{
if [ -e $1.s ]
then
    local str=$( echo "$( smsp $1 ) * -1.0080639 * 2.194746313705 / 10" | bc -l )
fi
check $str
}

dens ()
{
if [ -e $1.d ]
then
  local str=$( echo "$( head -5 $1.d | tail -1 | gawk '{ print $2 }' )" | bc -l )
fi
check $str
}

viriel ()
{
if [ -e $1.s ]
then
  local str=$( tail -1 $1.s | gawk '{ print $2 }' )
fi
check $str
}

hfsal ()
{
if [ -e $1.h ]
then
  local str=$( tail -3 $1.h | head -1  | gawk '{ print $1 }' )
fi
check $str
}

hfsad ()
{
if [ -e $1.h ]
then
  local str=$( tail -3 $1.h | head -1  | gawk '{ print $2 }' )
fi
check $str
}

hfsac ()
{
if [ -e $1.h ]
then
  local str=$( tail -3 $1.h | head -1  | gawk '{ print $3 }' )
fi
check $str
}

hfsb ()
{
if [ -e $1.h ]
then
  local str=$( tail -3 $1.h | head -1  | gawk '{ print $4 }' )
fi
check $str
}

conv ()
{
if [ -e $1.err ]
then
  if grep -q '0.000000000000000' $1.err
  then
    echo 'OK(?)'
  else
    echo $( tail -1 $1.err | gawk '{ print $3 }' )
  fi
else echo '     -     '
fi
}

mainconf ()
{
if [ -e $1.l ]
then
  string=$( head -7 $1.l | tail -1 | gawk '{ print $1 }' )
  local str=$( echo ${string:1:9} )
fi
check $str
}

ncfgl ()
{
if [ -e $1.l ]
then
  local str=$( head -1 $1.l | gawk '{ print $10 }' )
fi
check $str
}

2J ()
{
J=$1
if [[ $J =~ / ]]
then
  echo ${J%/*}
else
  echo $(( $J * 2 ))
fi
}

enbpci ()
{
J=$( 2J $2 )
if [ -e $1.j ]
then
  local str=$( grep -A2 "2\*J = *${J}" $1.j | tail -1 | gawk '{print $2}' )
fi
check $str
}

hfsA ()
{
if [ -e $1.h ]
then
  local str=$(grep "^ *$2 *$3" $1.h | head -1 | gawk '{ print $6 }')
fi
check $str
}

hfsB ()
{
if [ -e $1.h ]
then
  local str=$(grep "^ *$2 *$3" $1.h | tail -1 | gawk '{ print $3 }' )
fi
check $str
}

###################

Dencmkmchf ()
{
local a=$( enmchf $1 )
local b=$( enmchf $2 )
if $( isnumber $a $b )
then
  local str=$(echo "219474.63*($a - $b)" | bc -l)
fi
check $str
}
Dencmkbpci ()
{
local a=$( enbpci $1 $2 )
local b=$( enbpci $3 $4 )
if $( isnumber $a $b )
then
  local str=$(echo "219474.63*($a - $b)" | bc -l)
fi
check $str
}


for f in enmchf smsp
do
eval "D$f ()
{
local a=\$( $f \$1 )
local b=\$( $f \$2 )
if \$( isnumber \$a \$b )
then
  local str=\$(echo \$a - \$b | bc -l)
fi
echo \$( check \$str )
}"
done
for f in enbpci
do
eval "D$f ()
{
local a=\$( $f \$1 \$2 )
local b=\$( $f \$3 \$4 )
if \$( isnumber \$a \$b )
then
  local str=\$(echo \$a - \$b | bc -l)
fi
echo \$( check \$str )
}"
done


DKsmsmchfTHz ()
{
local a=$( smsp $1 )
local b=$( smsp $2 )
if $( isnumber $a $b )
then
  local str=$(echo "-3.60931615819233207436*($a - $b)" | bc -l)  # 6579.683920722 * -.99995377536420009574 * 0.00054858
fi
check $str
}


