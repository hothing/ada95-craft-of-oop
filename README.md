# ADA 95: THE CRAFT OF OBJECT-ORIENTED PROGRAMMING -- EXAMPLES

This archive contains the example programs from "Ada 95: The Craft of
Object-Oriented Programming" by John English (Prentice Hall 1997).
This book is now out of print, so I've converted it to HTML format
and released it online (see http://www.it.bton.ac.uk/staff/je/adacraft/).
Errata from the printed copy of the book and minor errors from earlier
versions of these examples have been corrected. The examples have been
tested using GNAT 3.13p on Linux and Windows platforms.

## Building the examples.

The examples from each chapter are in separate subdirectories (ch02
through ch19, corresponding to chapters 2 through 19).  Most chapters
contain multiple examples, and these are in separate subdirectories
called "egXX" where XX is the example number.  There is also a "packages"
subdirectory containing the final version of each of the major packages
developed in the book.  See the file "examples.txt" for a description of
the examples supplied.

Since many of the files are used in more than one example, the distribution
for Unix systems (adacraft.tar.gz) uses symbolic links to avoid unnecessary
duplication of files.  Take care if you want to modify any of the files, as
you might end up modifying the master copy in the process! The distribution
for Windows (adacraft.zip) doesn't use symbolic links, so many of the files
are duplicated. The distribution is a bit bigger, but it also means that you
don't need to worry about modifying a master copy of a file.

You can compile all the examples by running "sh build.sh" on Unix systems,
or "build.bat" on Windows systems.  This assumes that you have the GNAT
compiler installed on your system.

## Examples

The examples listed here are cross-referenced to the text.  You can build
all these examples using the build script supplied, or you can change to
the appropriate directory and use the command "gnatmake TARGET -cargs -gnato"
(e.g. change to ch02/eg01 and say "gnatmake hello -cargs -gnato").

### Chapter 2 -- Fundamentals of Ada

ch02/eg01/hello		-- The very first "Hello world" program
ch02/eg02/hello		-- The same, but with no layout
ch02/eg03/hello		-- "Hello world" illustrating "use" clauses
ch02/eg04/hello_3	-- Using Hello procedure from library in another program
ch02/eg05/hello_3	-- The same, but done "by hand"
ch02/eg06/sum		-- Program to add two integers together
ch02/eg07/hello		-- "Hello world" illustrating use of "Put_Line"

### Chapter 3 -- Statements

ch03/eg01/greetings	-- Display "Good morning" or "Good afternoon"
ch03/eg02/greetings	-- The same, with nested "if" statement
ch03/eg03/greetings	-- The same but using "elsif"
ch03/eg04/greetings	-- The same, illustrating assignment statements
ch03/eg05/greetings	-- The same, illustrating compound conditions
ch03/eg06/greetings	-- The same, illustrating "case" statements
ch03/eg07/greetings	-- The same, illustrating "loop" and "exit"
ch03/eg08/greetings	-- The same, illustrating "exit when"
ch03/eg09/calculator	-- A simple calculator (two operands separated by operator)
ch03/eg10/calculator	-- The same, skipping spaces before operator
ch03/eg11/calculator	-- Left-to-right calculator (sequence of operands & operators)
ch03/eg12/calculator	-- The same, with exception handling
ch03/eg13/get_integer	-- Program to get an integer using exception handling in a loop

### Chapter 4 -- Procedures, functions and packages

ch04/eg01/weekday	-- Find the day of the week using Zeller's Congruence
ch04/eg02/weekday	-- The same, with an internal procedure
ch04/eg03/weekday	-- The same, with an internal function
ch04/eg04/weekday	-- The same, with a separate function
ch04/eg05/weekday	-- The same, with a library function
ch04/eg06/weekday	-- The same, with a package
ch04/eg07/weekday	-- The same, with a hidden function in the package
ch04/eg08/weekday	-- The same, with package initialization
ch04/eg09/weekday	-- The same, with a child package
ch04/eg10/weekday	-- The same, with a child function

### Chapter 5 -- Defining new data types

ch05/eg01/greetings	-- "Greetings" program using Ada.Calendar.Clock
ch05/eg02/greetings	-- The same, using constants
ch05/eg03/greetings	-- The same, using an enumeration type

### Chapter 6 -- Composite data types

ch06/eg01/sort		-- Shuffle sort an array of integers
ch06/eg02/init_test	-- Demonstration of record type auto-initialization
ch06/eg03/weekday	-- "Weekday" program using an enumeration for the month

### Chapter 7 -- Exceptions

ch07/eg01/weekday	-- Earlier version of "weekday" program with
			   exception handling
ch07/eg02/weekday	-- The same, but using subtypes
ch07/eg03/weekday	-- The same, using Ada.Calendar to validate date
ch07/eg04/weekday	-- The same, illustrating "others" exception handler
ch07/eg05/weekday	-- The same, using a loop to get a valid date
ch07/eg06/weekday	-- The same, using a local variable
ch07/eg07/weekday	-- The same, but using Skip_Line to make it work
			   properly!
ch07/eg08/weekday	-- The same, illustrating Exception_Name
ch07/eg09/word_count	-- Program to count words in a file

### Chapter 8 -- Program design and debugging

ch08/eg01/diary		-- Diary program, initial version with stubs
ch08/eg02/diary		-- The same, with debugging modifications
ch08/eg03/diary		-- The same, with first bug fix
ch08/eg04/diary		-- The same, with end-of-file bugfix
ch08/eg05/diary		-- The same, with List and Add implemented
ch08/eg06/diary		-- The same, with Delete implemented
ch08/eg07/diary		-- The same, with Load and Save implemented
ch08/eg08/diary		-- The same, final version of this approach

### Chapter 9 -- Private data types

ch09/eg01/date_test	-- Test program for abstract data type for dates
ch09/eg02/date_test	-- The same, illustrating deferred constants
ch09/eg03/date_test	-- The same for improved date ADT
ch09/eg04/date_test	-- The same, illustrating bad use of operator  overloading
ch09/eg05/date_test	-- The same, using wrapper for Ada.Calendar

### Chapter 10 -- Designing with abstract data types

ch10/diary		-- ADT-based appointments diary

### Chapter 11 -- Dynamic memory allocation

ch11/eg01/diary		-- Appointments diary using linked list
ch11/eg02/weekday	-- "Weekday" program using ragged array for day names

### Chapter 12 -- Generics

ch12/eg01/diary		-- Appointments diary using generic linked lists
ch12/eg02/sort		-- Illustration of generic sorting procedure
ch12/eg03/diary		-- Illustration of generics and access-to-subprogram types

### Chapter 13 -- Building a calculator

ch13/eg01/calculator	-- Stack-based calculator with precedence
ch13/eg02/calculator	-- The same, with parenthesised subexpressions
ch13/eg03/calculator	-- The same, with list-based stack package
ch13/eg04/calculator	-- The same, with opaque (array) type for stack
ch13/eg05/calculator	-- The same, with opaque (list) type for stack
ch13/eg06/fact_test	-- Illustration of recursive function to calculate factorials
ch13/eg07/evaluate	-- Calculator using a recursive descent parser

### Chapter 14 -- Tagged types

ch14/eg01/diary		-- Meetings diary, using embedded appointment in meeting type
ch14/eg02/var_test	-- Illustration of variant records
ch14/eg03/diary		-- Meetings diary using tagged type for appointments

### Chapter 15 -- Polymorphism and dispatching

ch15/eg01/diary		-- Heterogenous diary using dispatching
ch15/eg02/diary		-- The same, including a "deadline" type

### Chapter 16 -- Controlled types

ch16/eg01/diary		-- Diary, with explicit deallocation of deleted entries
ch16/eg02/pointer_test	-- Test program for "smart pointer" type

### Chapter 17 -- An object-oriented calculator

ch17/calculator		-- Calculator using object-oriented techniques

### Chapter 18 -- Designing a spreadsheet

ch18/spreadsheet	-- Spreadsheet using extension of calculator from chapter 17

### Chapter 19 -- Multitasking

ch19/eg01/task_test	-- Illustration of multitasking
ch19/eg02/task_test	-- The same, with task discriminants
ch19/eg03/task_test	-- Illustration of task rendezvous
ch19/eg04/test		-- Illustration of unsafe access to global data
ch19/eg05/test		-- The same made safe using a protected record
ch19/eg06/spreadsheet	-- Extension of spreadsheet providing active cells

## GNAT bugs and workarounds.

There are some known problems outstanding due to bugs in GNAT:

Extension aggregates:
   Affects:  ch14/eg03, ch15/eg01, ch15/eg02, ch16/eg01
   Status:   GNAT 3.01 - 3.05
   Symptom:  The common appointment part of derived appointments gets
             lost (and dates usually appear as 1-JAN-1970 as a result).
             Interestingly enough, extension aggregates used to work
             properly in GNAT 2.07... :-(
   Solution: Upgrade to GNAT 3.07 or later where the problem has been fixed,
             or copy the files in the ch14/ch15/ch16 subdirectories of the
             "fixes" directory to the corresponding chapter subdirectories.
             These do everything the long way round, avoiding the use of
             extension aggregates.

The 'Class'Input attribute:
   Affects:  ch15/eg01, ch15/eg02, ch16/eg01
   Status:   GNAT 3.01
   Symptom:  GNAT 3.01 incorrectly reports an error  when 'Class'Input or
             'Class'Output are used with for an abstract class.  To get
             around this, the abstract parent type can be derived from a
             concrete type which can then be used to call 'Class'Input or
             'Class'Output.  Unfortunately this won't help; loading a diary
             will fail, usually with a Data_Error.  This is because the
             'Class'Input routine skips some of the data as it reads the
             file (but 'Class'Output works fine!).
   Solution: Upgrade to GNAT 3.03 or later, where the problem has been fixed.

Exception handling:
   Affects:  ch18
   Status:   GNAT 3.01 (only under SunOS)
   Symptom:  Cells containing formulas which reference empty cells will
             crash with a protection fault.  An Undefined_Cell_Error is
             being raised but never gets to its handler.
   Solution: Upgrade to GNAT 3.03 or later where the problem has been fixed,
             or use GNAT 3.01 under any other operating system.

Tasking not supported under MS-DOS:
   Affects:  ch19 (all)
   Status:   GNAT 3.01 - 3.03 (MS-DOS)
   Symptom:  All examples from chapter 19 fail to link with the MS-DOS
             port of the compiler.
   Solution: Use a different operating system, or upgrade to GNAT 3.04 or
             later.

Tasks with discriminants:
   Affects:  ch19/eg02, ch19/eg06
   Status:   GNAT 3.01
   Symptom:  Discriminant values are not passed correctly to tasks, so
             the task test program in example 2 will be executed a random
             (usually large!) number of times.
   Solution: Upgrade to GNAT 3.03 or later, where the problem has been fixed.

Tasks as components in a type extension:
   Affects:  ch19/eg06
   Status:   GNAT 3.01 - 3.08
   Symptom:  If a task is used as a component when deriving from a tagged
             type, the compiler will crash with an assertion error if you
             try to create an object of the derived type using "new".
   Solution: Copy the files in the ch19 subdirectory of the "fixes" directory
             to the corresponding chapter subdirectory.  This uses a pointer
             to a task as the record component rather than using a task; the
             constructor function is modified to create the task using "new"
             and assign the resulting pointer to the record component.  Note
             that under GNAT 3.01 the program will then compile but it will
             crash when you try to run it because the task discriminant (a
             pointer to the spreadsheet) will have been passed to the task
             incorrectly, as described above.

Get_Immediate broken:
   Affects:  ch19/eg06
   Status:   GNAT 3.01 - 3.08 (SunOS, Solaris, Win95/NT)
   Symptom:  Get_Immediate ignores keyboard input (except ^C) under SunOS
             and Solaris; under Windows 95/NT it behaves like Get (i.e.
             it blocks until the Enter key has been pressed).  It works
             fine under other operating systems.
   Solution: Use a different operating system, or upgrade to GNAT 3.05 or
             later in the case of SunOS/Solaris.

The compiler bugs have been reported to the GNAT development team, so hopefully
they will be fixed in a future release.  Any other bugs are entirely my fault;
please email me at the address below if you discover any, or if you have any
other comments or suggestions to make.  Note that I have deliberately left
some examples incomplete (e.g. the lack of Data_Error handling in the diary
package's Load procedure) so that readers still have some work to do; these
omissions are features, not bugs (:-).  The documentation in the examples is
also minimal; it's all in the book (implication: buy the book!).  And most
importantly of all, have fun learning Ada 95!



                                    -- John English (je@brighton.ac.uk).
