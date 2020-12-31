----------------------------------------------------------------------------
--
--   File:    diary.adb
--   Purpose: Electronic diary program using generic menu package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Menus, JE.Diaries;
procedure Diary is
    package Diary_View is
        procedure Load_Diary         (Diary : in out JE.Diaries.Diary_Type);
        procedure Save_Diary         (Diary : in JE.Diaries.Diary_Type);
        procedure Add_Appointment    (Diary : in out JE.Diaries.Diary_Type);
        procedure List_Appointments  (Diary : in JE.Diaries.Diary_Type);
        procedure Delete_Appointment (Diary : in out JE.Diaries.Diary_Type);
    end Diary_View;

    package body Diary_View is separate;

    Diary_Model : JE.Diaries.Diary_Type;

    procedure Add is
    begin
        Diary_View.Add_Appointment (Diary_Model);
    end Add;

    procedure Delete is
    begin
        Diary_View.Delete_Appointment (Diary_Model);
    end Delete;

    procedure List is
    begin
        Diary_View.List_Appointments (Diary_Model);
    end List;

    procedure Save is
    begin
        Diary_View.Save_Diary (Diary_Model);
    end Save;

    package Menus is new JE.Menus;
    Menu : Menus.Menu_Type;

begin
    Menus.Add (Menu, "Add appointment",    'A', Add'Access);
    Menus.Add (Menu, "Delete appointment", 'D', Delete'Access);
    Menus.Add (Menu, "List appointments",  'L', List'Access);
    Menus.Add (Menu, "Save appointments",  'S', Save'Access);

    begin
        Diary_View.Load_Diary (Diary_Model);
    exception
        when JE.Diaries.Diary_Error =>
            null;
    end;

    while Menus.Execute(Menu) loop
        null;
    end loop;
end Diary;
