@echo off

rem ------------------------------------------------------------------------
rem
rem     File:    build.bat
rem     Purpose: Build executables for all examples
rem     Author:  John English (je@brighton.ac.uk)
rem
rem     This code is from "Ada 95: The Craft of Object-Oriented Programming"
rem     by John English (Prentice Hall 1996). Copyright (c) John English.
rem     Permission is granted to copy and distribute this file for
rem     non-commercial use only.
rem
rem ------------------------------------------------------------------------

echo +++ ch02 +++
cd ch02
   echo ... eg01 ...
   cd eg01
      gnatmake hello.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake hello.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake hello.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake hello_3.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake hello_3.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake sum.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake hello.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch03 +++
cd ch03
   echo ... eg01 ...
   cd eg01
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg08 ...
   cd eg08
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg09 ...
   cd eg09
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg10 ...
   cd eg10
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg11 ...
   cd eg11
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg12 ...
   cd eg12
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg13 ...
   cd eg13
      gnatmake get_integer.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch04 +++
cd ch04
   echo ... eg01 ...
   cd eg01
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg08 ...
   cd eg08
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg09 ...
   cd eg09
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg10 ...
   cd eg10
      gnatmake weekday.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch05 +++
cd ch05
   echo ... eg01 ...
   cd eg01
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake greetings.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake greetings.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch06 +++
cd ch06
   echo ... eg01 ...
   cd eg01
      gnatmake sort.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake init_test.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake weekday.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch07 +++
cd ch07
   echo ... eg01 ...
   cd eg01
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg08 ...
   cd eg08
      gnatmake weekday.adb -cargs -gnato
      cd ..
   echo ... eg09 ...
   cd eg09
      gnatmake word_count.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch08 +++
cd ch08
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg08 ...
   cd eg08
      gnatmake diary.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch09 +++
cd ch09
   echo ... eg01 ...
   cd eg01
      gnatmake date_test.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake date_test.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake date_test.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake date_test.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake date_test.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch10 +++
cd ch10
   gnatmake diary.adb -cargs -gnato
   cd ..
echo +++ ch11 +++
cd ch11
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake weekday.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch12 +++
cd ch12
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake sort.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake diary.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch13 +++
cd ch13
   echo ... eg01 ...
   cd eg01
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake calculator.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake fact_test.adb -cargs -gnato
      cd ..
   echo ... eg07 ...
   cd eg07
      gnatmake evaluate.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch14 +++
cd ch14
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake var_test.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake diary.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch15 +++
cd ch15
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake diary.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch16 +++
cd ch16
   echo ... eg01 ...
   cd eg01
      gnatmake diary.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake pointer_test.adb -cargs -gnato
      cd ..
   cd ..
echo +++ ch17 +++
cd ch17
   gnatmake calculator.adb -cargs -gnato
   cd ..
echo +++ ch18 +++
cd ch18
   gnatmake spreadsheet.adb -cargs -gnato
   cd ..
echo +++ ch19 +++
cd ch19
   echo ... eg01 ...
   cd eg01
      gnatmake task_test.adb -cargs -gnato
      cd ..
   echo ... eg02 ...
   cd eg02
      gnatmake task_test.adb -cargs -gnato
      cd ..
   echo ... eg03 ...
   cd eg03
      gnatmake task_test.adb -cargs -gnato
      cd ..
   echo ... eg04 ...
   cd eg04
      gnatmake task_test.adb -cargs -gnato
      cd ..
   echo ... eg05 ...
   cd eg05
      gnatmake task_test.adb -cargs -gnato
      cd ..
   echo ... eg06 ...
   cd eg06
      gnatmake spreadsheet.adb -cargs -gnato
      cd ..
   cd ..
