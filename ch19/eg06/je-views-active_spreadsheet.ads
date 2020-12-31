----------------------------------------------------------------------------
--
--   File:    je-views-active_spreadsheet.ads
--   Purpose: User interface package (specification) for active spreadsheet
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Spreadsheets.Active;
package JE.Views.Active_Spreadsheet is
    type Command_Type is (Modify, Display, Quit);
    type Sheet_Type   is limited private;

    function  Next_Command (Sheet : access Sheet_Type) return Command_Type;
    procedure Display      (Sheet : in out Sheet_Type);
    procedure Modify       (Sheet : in out Sheet_Type);
private
    type Sheet_Extension is new JE.Spreadsheets.Active.Active_Spreadsheet_Type
                                        with null record;
    procedure Display (Sheet : in out Sheet_Extension);

    type Sheet_Type is
        record
            Innards : aliased Sheet_Extension;
        end record;
end JE.Views.Active_Spreadsheet;
