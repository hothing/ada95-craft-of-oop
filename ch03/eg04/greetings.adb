----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using assignment to convert upper case
--            to lower case)
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
    Put ("Is it morning (m) or afternoon (a)? ");
    Get (Answer);
    if Answer = 'M' then                                  --  1
        Answer := 'm';                                    --  2
    elsif Answer = 'A' then                               --  3
        Answer := 'a';                                    --  4
    end if;                                               --  5
    if Answer = 'm' then
        Put_Line ("Good morning!");
    elsif Answer = 'a' then
        Put_Line ("Good afternoon!");
    else
        Put_Line ("Please type 'm' or 'a'!");
    end if;
end Greetings;
