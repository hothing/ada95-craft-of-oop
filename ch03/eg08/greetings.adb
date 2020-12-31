----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using "exit when")
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
    Answer : Character;
begin
    loop
        Put ("Is it morning (m) or afternoon (a)? ");
        Get (Answer);
        exit when Answer = 'm' or Answer = 'M'
               or Answer = 'a' or Answer = 'A';
        Put_Line ("You must type m or a!");
    end loop;
    if Answer = 'm' or Answer = 'M' then                        -- 1
        Put_Line ("Good morning!");
    else
        Put_Line ("Good afternoon!");
    end if;
end Greetings;
