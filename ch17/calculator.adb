----------------------------------------------------------------------------
--
--   File:    calculator.adb
--   Purpose: Calculator program using extensible expression parser
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Expressions, Ada.Exceptions;
use  Ada.Text_IO, Ada.Integer_Text_IO, JE.Expressions;
procedure Calculator is
    Expr  : Expression_Type;
    Line  : String(1..80);
    Len   : Natural;
    Value : Integer;
begin
    Put ("Enter an expression: ");
    Get_Line (Line, Len);
    Value := Evaluate (Expr, Line(1..Len));
    Put ("Result = ");
    Put (Value, Width=>1);
    New_Line;
exception
    when Constraint_Error =>
        Put_Line ("Result out of range");
    when E : Syntax_Error =>
        Put ("Syntax Error: ");
        Put_Line (Ada.Exceptions.Exception_Message(E));
        New_Line;
end Calculator;
