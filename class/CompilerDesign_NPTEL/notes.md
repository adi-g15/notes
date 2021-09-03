# Intro

Each language has a grammar to verify it is gramatically correct

Sometimes compiler give warnings... for eg, in

```
int x;
x = 10.5;

x = (int)10.5;
```

In this, say compiler knows 4 bytes for integer, but for float it may be different for eg. 4 or 6, so it maynot be very clear to compiler to how to do this assignment...
Though in 3rd one, i am explicit, so compiler knows it must be integer value then assign to variable.
So, in first case compiler may give warnings.

```
Source -> Compiler -> Target Program
           |    |
      Warnings Errors
```

# Compiler Applications

## Machine code generation

* Take care of semantics of various constructs of the language
* Consider limitations/features of target machine
* Automata theory helps in syntactic checks - valid/invalid programs, **it does not answer anything beyond yes or no**, but if answer is know, in that case also the compiler has to give enough indication what is wrong

## Format converters

* Act as interfaces b/w 2 or more software packages, they are very common
* Also used to convert heavily used programs written in older languages (COBOL) to newer languages (C/C++)

## Silicon compilation

* Automatically synthesize a circuit from its behavorial description... eg in complex processors no need to start from adders and subtractors, and is the opposite way, give the behavorial description

## Query Optimisation

* In domain of database query processing, optimize search time

## Text formatting

* Accept ordinary text as input having formatting commands embedded
* eg. troff, nroff, latex etc

> The lecture portion sounded for like Markdown etc

# Phases of a Compiler

Practically speaking, they are not demarcable clearly, but for understanding we divide into these:
1. Lexical Analysis:
   For any lang, first thing, alphabets, words, sentences
2. Syntax
   In this we do grammatical check
3. Semantic
   In this we find problems in *meanings* for eg. some variable is undefined
4. Intermediate Code Generation
   Based on automata theory, all next steps basically use this info from automata theory
5. Target Code Generation
6. Code Optimisation
7. Symbol table management
8. Error Handling & Recovery
   If error on line 10, don't stop there, go on to try all other maybe some more errors on line 20, 36 etc.

## Lexical analysis

* Interface of the compiler to outside world
* Removes all 'cosmetics', whitespaces comments etc.

* Generates sequence of integers, called tokens to be passed to the syntax analysis phase, later phases neet not worry about program text
* Generally implemented as a finite automata

## Syntax Analysis (Parser)

Works hand-in-hand with lexical analyser.
So it's not that lexical will generate all tokens and then parser works on it.

Instead, parser starts, and as and when it needs the next token, it will ask the lexical analyser for this, and the lexical analyser will scan the input and return the next probable token.

* Checks syntactic (grammatical) correctness
  For eg. each language has a grammar consider if else, for eg it should be
  > if <condition> then { block } [ else {} ]   // <- else block is optional, but if else is there it must be followed by a block

  So we can't write `if then S1 else S2`, because we missed the condition, so parser also checks for these

There is a `Start symbol` of the grammar of a language, so all allowed strings in the language L(say), can be generated from the start symbol S, using the grammar G, so theoretically the program text can be generated from S, and if the program is incorrect or has syntactic errors, then if will not be possible to generate the program text from the starting symbol.

Then, if program is correct, a parse tree is generated...
For eg there is this statement `x = y+z*r`,
So we generate it's parse tree like:
```
        S
     id =  E
        E  +  E
       id(y)  E*E
              id*id
	      (z) (r)
```

> Errors given out for syntactic errors

## Semantic analysis

Dependent on the language

* Type checking
* Whether operand can be applied to operands (for eg x = y+z; so it's desirable that y+z has same type as x)
* Scope (static & dynamic scope)

## Intermediate code

> Optional stage, can directly go for target code

#### Why needed ?

Because, say I generate code for Intel x86 arch, we know it has so and so instruction set. Tommorow if i have to use the same compiler to generate code for another processor, so same code will not run there, so I have to write the entire code generation phase again, and since it is generally integrated with the parsing stage, then we need to start modifying parser step too, so that makes it difficult. So, retargetting architectures become simpler with intermediary language.

Intermediate language provide us freedom to chose like my language will support this and this, and when done well, it may become a template substitution kind of, where we substitute with proper instructions for the particular architecure

#### How complex or how simple ?

It can't be too simple to not be able to express constructs of the language

It can't be too complex, bcz then we will be much far away from target (machine code), so will require another compiler to get from intermediate to machine language.

For eg. if it supports the instruction `x=y+z`, I can more easily retarget machines, for eg. machine1 allows directly reading from memory, while machine2 can only access registers for addition, then it becomes template substitution kind of...

```
M1:
  ADD   y,z,R1
  STORE x,R1
M2:
  LOAD  R1,y
  LOAD  R2,z
  ADD   R1,R2
  STORE x,R1
```

## Target code generation

Uses template substitution from intermediate code
Predefined target language templates are used

Machine instructions, addressing modes, CPU registers play vital roles
Temporary variables are packed into CPU registers

## Optimisation

* Automated steps of compilers generate lot of redundant code

It is NP-hard, so we don't generally give huge block of code to compile.
Code is divided into _basic blocks_ - a sequence of statements with single entry and single exit
 
For eg.
```rs
if a > 4 {
  a = 1;
} else {
  a = 0;
}
```
So the whole if+else block is NOT basic block, since it has one entry but TWO exit points, either the if condition or the else condition block will run next;
Though, the blocks itself is basic block, since it has one beginning and one exit, they are much easier to optimise.

* Local Optimisation : optimisations within a basic block
* Global optimisations: spans across basic blocks

> Sources of optimisation are loops, elimintation of load-store etc.

## Symbol Table Management

> Not part of final code, but required for reference by compilation stages

For eg.
```
int x;
```

The symbol table will have datatype, size, and _relative offset_ (for eg. 2nd byte from the start of program), since program start location can be different with each run in memory, so we use relative offset, instead of absolute address like 4000, etc.

This is mostly used by parser, though maybe used by lexical to check for duplicate tokens

## Error and recovery

When error occured remove some tokens and recover to a correct enough state, then proceed to parse the rest of program to find more errors.

# Next...

Compilers depend on OS for things like file I/O.
Format of file to be executed is depicted by OS (more specifically, loader)

## Runtime Environment

Deal with creating space for parameters, local variables, stack frames (for functions and local variables)

