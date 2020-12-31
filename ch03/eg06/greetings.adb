----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using "case" statement)
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
    case Answer is
        when 'M' | 'm' =>                                --  1
            Put_Line ("Good morning!");
        when 'A' | 'a' =>                                --  2
            Put_Line ("Good afternoon!");
        when others    =>                                --  3
            Put_Line ("Please type 'm' or 'a'!");
    end case;
end Greetings;
