## Shell Scripting

numeric expression for operators
Operator - meaning
-gt 	- greater than
-ge 	- greater than or equal to
-lt 	- less than
-le 	- less than or eqaul to
-eq	- equal to
-ne	- not equal to

for string expression
=	- equal to
!=	- not equal to
Ex.
    'string1'='string2'
    'string1'!='string2'
for logical operator
-a ---> and
-o ---> or
-n ---> not

if statement in unix
if is a powerful desicion making statement/ for conditional
there are four form
1. simple if
2. if else
3. nested if else
4. laddar if else

1. simple if statement
syntax:-
  if [ condition ]                []/test
  then
    statement
  fi

or, 
   if test condition 
   then
     statement
   fi

ex. a=10
    b=20
    if [ $a -gt $b ]
    then
       echo "a is greater no"
    fi
  
2. if else statement (with [ ] brakets)
syntax:-
   if [ condition ]
   then
       statement
   else
       statement
   fi

or,
if else statement (without [ ] brackets)
syntax:-
   if test condition 
   then
       statement
   else
       statement
   fi
ex.
a=10
b=20
if [ $a -gt $b ]
then
  echo "a is greater no"
else
  echo "b is  greater no."
fi

output:-
  b is greater no
***********

3. Nested if else ( if within if )
syntax:-
if [ condition ]
then
    
  if [ condition ]
  then
   statement
else 
   if [ condition ]
   then
      statement
   else
      if [ condition ]
      then
         statement
      else
         statement
      fi
   fi
fi


4. Laddar if else
syntax:-
if [ condition ]
then
   statement
elif [ condition ]
   statement
elif [ condition ]
    statement
elif [ condition ]
   statement
else
   statement
fi  

********
 case .... esac statement (similar to switch case statement)
synatx:-
  case $variable in
  value1)  command;;
  value2)  command;;
  value3)  command;;
  .
  .
  valuen)  command;;
  .
  .
  *)     command;;
  esac
Ex.
write a shell script in unix to display a digit into word upto 3.
clear
echo enter any number
read n
case $n in
1) echo "One";;
2) echo "Two";;
3) echo "Three";;
*) echo "Invalid choice"
esac


while loop/statement in unix
syntax:-
while [ condition ]
do
  statement
done
Ex.
write a shell script in unix to find the sum of first 10 natural numbers

n=1
s=0
while [ $n -le 10 ]
do
  echo $n
  s=`expr $s + $n`
  n=`expr $n + 2`
done
  echo "Sum =" $s

Output:-
  Sum = 55


### for loop

syntax:-
for ((initialization; test condition; updation))
do
   statement
done

Ex.
  for((i=0;i<5;i++))
  do
    read arr[$i]
  done

#for the value in an array
for((i=0;i<5;i++))
  do
    echo  ${arr[$i]}
  done

