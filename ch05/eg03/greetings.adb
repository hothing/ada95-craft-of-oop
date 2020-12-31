----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using an enumeration type)
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
    type Time_Of_Day is (AM, PM);
    package Time_IO is new Enumeration_IO (Time_Of_Day);   use Time_IO;
    Answer : Time_Of_Day;
begin
    Put ("Is it morning (AM) or afternoon (PM)? ");
    Get (Answer);
    if Answer = AM then
        Put_Line ("Good morning!");
    else
        Put_Line ("Good afternoon!");  
    end if;
end Greetings;
