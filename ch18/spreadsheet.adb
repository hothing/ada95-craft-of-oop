----------------------------------------------------------------------------
--
--   File:    spreadsheet.adb
--   Purpose: Spreadsheet program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Views.Spreadsheet;
procedure Spreadsheet is
    Sheet : JE.Views.Spreadsheet.Sheet_Type;
begin
    JE.Views.Spreadsheet.Display (Sheet);
    loop
        case JE.Views.Spreadsheet.Next_Command is
            when JE.Views.Spreadsheet.Modify =>
                JE.Views.Spreadsheet.Modify (Sheet);
            when JE.Views.Spreadsheet.Display =>
                JE.Views.Spreadsheet.Display (Sheet);
            when JE.Views.Spreadsheet.Quit =>
                exit;
        end case;
    end loop;
end Spreadsheet;
