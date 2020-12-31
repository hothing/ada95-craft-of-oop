----------------------------------------------------------------------------
--
--   File:    diary.adb
--   Purpose: Electronic diary program for appointments and meetings
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Views.Diary, JE.Diaries;
use  JE.Views.Diary;
procedure Diary is
    Diary_Model : JE.Diaries.Diary_Type;
begin
    begin
        Load_Diary (Diary_Model);
    exception
        when JE.Diaries.Diary_Error =>
            null;
    end;

    loop
        case Next_Command is
            when Add =>
                Add_Appointment (Diary_Model);
            when List =>
                List_Appointments (Diary_Model);
            when Delete =>
                Delete_Appointment (Diary_Model);
            when Save =>
                Save_Diary (Diary_Model);
            when Quit =>
                exit;
        end case;
    end loop;
end Diary;
