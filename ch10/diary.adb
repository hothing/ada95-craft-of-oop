----------------------------------------------------------------------------
--
--   File:    diary.adb
--   Purpose: Electronic appointments diary program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Diaries;
procedure Diary is
    package Diary_View is
        type Command_Type is (Add, List, Delete, Save, Quit);
        function Next_Command return Command_Type;

        procedure Load_Diary         (Diary : in out JE.Diaries.Diary_Type);
        procedure Save_Diary         (Diary : in JE.Diaries.Diary_Type);
        procedure Add_Appointment    (Diary : in out JE.Diaries.Diary_Type);
        procedure List_Appointments  (Diary : in JE.Diaries.Diary_Type);
        procedure Delete_Appointment (Diary : in out JE.Diaries.Diary_Type);
    end Diary_View;

    package body Diary_View is separate;

    Diary_Model : JE.Diaries.Diary_Type;

begin
    begin
        Diary_View.Load_Diary (Diary_Model);
    exception
        when JE.Diaries.Diary_Error =>
            null;
    end;

    loop
        case Diary_View.Next_Command is
            when Diary_View.Add =>
                Diary_View.Add_Appointment (Diary_Model);
            when Diary_View.List =>
                Diary_View.List_Appointments (Diary_Model);
            when Diary_View.Delete =>
                Diary_View.Delete_Appointment (Diary_Model);
            when Diary_View.Save =>
                Diary_View.Save_Diary (Diary_Model);
            when Diary_View.Quit =>
                exit;
        end case;
    end loop;
end Diary;
