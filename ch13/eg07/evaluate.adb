----------------------------------------------------------------------------
--
--   File:    evaluate.adb
--   Purpose: Calculator using expression parser package
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Parser;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Evaluate is
    Value : Integer;
begin
    Put ("Enter an expression: ");
    Value := JE.Parser.Expression;
    if JE.Parser.Next_Character /= ';' then
        raise JE.Parser.Syntax_Error;
    end if;
    Put (Value);
    New_Line;
exception
    when JE.Parser.Syntax_Error =>
        Put_Line ("Syntax error!");
end Evaluate;
