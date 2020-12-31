----------------------------------------------------------------------------
--
--   File:    je-expressions-spreadsheet.adb
--   Purpose: Extended expression package for use in a spreadsheet (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Spreadsheets;  use JE.Spreadsheets;
package body JE.Expressions.Spreadsheet is
    use JE.Expressions.Token_Pointers;

    function Value (Operand : Cell_Operand_Type) return Integer is
    begin
        if Operand.Cell = null then
            raise Undefined_Cell_Error;
        else
            Evaluate (Operand.Cell.all);
        end if;
        return Num_Value (Operand.Cell.all);
    end Value;

    procedure Fetch_Token (Syntax : in Formula_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Token  : in out Token_Pointer) is
    begin
        case Expr(From) is
            when 'A'..'Z' | 'a'..'z' =>
                declare
                    First    : Integer := From;
                    Cell_Ptr : Cell_Access;
                begin
                    while (From <= Expr'Length) and then
                          (Expr(From) in 'A'..'Z' or
                           Expr(From) in 'a'..'z' or
                           Expr(From) in '0'..'9')
                    loop
                        From := From + 1;
                    end loop;
                    Cell_Ptr := Cell (Syntax.Sheet.all, Expr(First..From-1));
                    Token := Pointer(new Cell_Operand_Type(Cell_Ptr));
                end;
            when others =>
                Fetch_Token(Expression_Type(Syntax), Expr, From, Token);
        end case;
    end Fetch_Token;
end JE.Expressions.Spreadsheet;
