----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using "if" statement)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;   use Ada.Text_IO; 
procedure Greetings is
    Answer : Character;                                   --  1
begin
    Put ("Is it morning (m) or afternoon (a)? ");         --  2
    Get (Answer);                                         --  3
    if Answer = 'm' then                                  --  4
        Put_Line ("Good morning!");                       --  5
    else                                                  --  6
        Put_Line ("Good afternoon!");                     --  7
    end if;                                               --  8
end Greetings;                                            --  9
