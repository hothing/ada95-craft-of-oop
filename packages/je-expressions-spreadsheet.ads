----------------------------------------------------------------------------
--
--   File:    je-expressions-spreadsheet.ads
--   Purpose: Extended expression package for use in a spreadsheet
--            (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Spreadsheets;
use  JE.Spreadsheets;
package JE.Expressions.Spreadsheet is
    type Formula_Type (Sheet : access Spreadsheet_Type'Class) is
                               new Expression_Type with private;

private
    type Cell_Operand_Type (Cell : Cell_Access) is new Operand_Type
            with null record;
    function Value (Operand : Cell_Operand_Type) return Integer;

    type Formula_Type (Sheet : access Spreadsheet_Type'Class) is
                               new Expression_Type with null record;
    procedure Fetch_Token (Syntax : in Formula_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Token  : in out Token_Pointer);
end JE.Expressions.Spreadsheet;
