----------------------------------------------------------------------------
--
--   File:    diary.adb
--   Purpose: Electronic diary (with bug fix for end-of-file character)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, JE.Diaries;
use  Ada.Text_IO, JE.Diaries;
procedure Diary is
    Command : Character;
begin
    Load_Diary;
    loop
        -- display menu
        New_Line (5);
        Put_Line ("Diary menu:");
        Put_Line ("   [A]dd appointment");
        Put_Line ("   [D]elete appointment");
        Put_Line ("   [L]ist appointments");
        Put_Line ("   [S]ave appointments");
        Put_Line ("   [Q]uit");
        New_Line;
        Put ("Enter your choice: ");

        -- get a command
        Get (Command);
        Skip_Line;

        -- perform selected command
        case Command is
            when 'A' | 'a' =>
                Add_Appointment;
            when 'D' | 'd' =>
                Delete_Appointment;
            when 'L' | 'l' =>
                List_Appointments;
            when 'S' | 's' =>
                Save_Appointments;
            when 'Q' | 'q' =>
                exit;
            when others =>
                Put_Line ("Invalid choice -- please enter A, D, L, S or Q");
        end case;
    end loop;
exception
    when End_Error =>       -- do nothing, just quit
        null;
end Diary;
