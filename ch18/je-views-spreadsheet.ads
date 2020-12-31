----------------------------------------------------------------------------
--
--   File:    je-views-spreadsheet.ads
--   Purpose: User interfcae package (specification) for spreadsheet program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Spreadsheets;
package JE.Views.Spreadsheet is
    type Command_Type is (Modify, Display, Quit);
    function Next_Command return Command_Type;

    type Sheet_Type is limited private;
    procedure Display (Sheet : in out Sheet_Type);
    procedure Modify  (Sheet : in out Sheet_Type);
private
    type Sheet_Extension is new JE.Spreadsheets.Spreadsheet_Type
                                        with null record;
    procedure Display (Sheet : in out Sheet_Extension);

    type Sheet_Type is
        record
            Innards : aliased Sheet_Extension;
        end record;
end JE.Views.Spreadsheet;
