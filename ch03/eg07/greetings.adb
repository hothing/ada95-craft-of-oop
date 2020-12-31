----------------------------------------------------------------------------
--
--   File:    greetings.adb
--   Purpose: Display a greeting (using a loop to validate input)
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
    loop                                                            -- 1
        Put ("Is it morning (m) or afternoon (a)? ");
        Get (Answer);
        if Answer = 'm' or Answer = 'M' then
            Put_Line ("Good morning!");
            exit;                                                   -- 2
        elsif Answer = 'a' or Answer = 'A' then
            Put_Line ("Good afternoon!");
            exit;                                                   -- 3
        else
            Put_Line ("You must type m or a!");
        end if;
    end loop;                                                       -- 4
end Greetings;                                                      -- 5
