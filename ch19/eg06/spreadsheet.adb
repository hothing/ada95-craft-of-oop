----------------------------------------------------------------------------
--
--   File:    spreadsheet.adb
--   Purpose: Main program for active spreadsheet
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Views.Active_Spreadsheet;
procedure Spreadsheet is
    Sheet : aliased JE.Views.Active_Spreadsheet.Sheet_Type;
begin
    JE.Views.Active_Spreadsheet.Display (Sheet);
    loop
        case JE.Views.Active_Spreadsheet.Next_Command (Sheet'Access) is
            when JE.Views.Active_Spreadsheet.Modify =>
                JE.Views.Active_Spreadsheet.Modify (Sheet);
            when JE.Views.Active_Spreadsheet.Display =>
                JE.Views.Active_Spreadsheet.Display (Sheet);
            when JE.Views.Active_Spreadsheet.Quit =>
                exit;
        end case;
    end loop;
end Spreadsheet;
