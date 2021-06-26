## Compare

* cal
* date
* who
* who am i
* write
* wall

* write -> Send message to other user
* wall  -> Write to all

* `comm` - sorted files; line by line


* `cmp`  - byte by byte
* `diff` - line by line

* expr command - it is used to solve arithmetic expression
```sh
  $r=`expr 1234 % 10 + 6`
  $echo $r
   10
```

* bc command - it is used to calculator

$bc
5+3
8
5*6
30

* wc

#Write a shell script in unix sort n number of elemetns using bubble sort
wc command 
it used to count the total number lines, words, and characters in a file
$wc filename

$wc -l for no of lines
$wc -w for no of words
$wc -c for no of characters
$cat > abc
I am a student of nit patna
I am a student of b.tech

lines=2
words=13
charaters=53


in shell script:-
* echo - display a message on screen
* read - it is used to take input from user

* awk command - it is used to find out specific rows in a file based on certain condition

# find the students who have passed their courses in the year 1999 from the file 'exstudent.dat'
$awk -F ',' "$4=1999' exstudent.dat

# List all the students records from 'student.dat' who are not studying M.Tech course
$awk -F ',' '$1!="M.Tech"' student.dat


## Mail and Print

mailx- to send and received mail;

lpr  - to print a file in unix
lprm - It is used to cancle print job

lpq  - It is used to show printer queue status
