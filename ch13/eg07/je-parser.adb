----------------------------------------------------------------------------
--
--   File:    je-parser.adb
--   Purpose: Simple expression parser (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;
package body JE.Parser is
    function Term return Integer;
    function Primary return Integer;

    function Next_Character return Character is
        Ch  : Character;
        EOL : Boolean;
    begin
        loop
            Look_Ahead (Ch, EOL);
            if EOL then
                return ';';
            elsif Ch /= ' ' then
                return Ch;
            else
                Get (Ch);
            end if;
        end loop;
    end Next_Character;

    function Expression return Integer is
        Value    : Integer;
        Operator : Character;
    begin
        Value := Term;
        loop
            Operator := Next_Character;
            exit when Operator /= '+' and Operator /= '-';
            Get (Operator);
            if Operator = '+' then
                Value := Value + Term;
            else
                Value := Value - Term;
            end if;
        end loop;
        return Value;
    end Expression;

    function Term return Integer is
        Value    : Integer;
        Operator : Character;
    begin
        Value := Primary;
        loop
            Operator := Next_Character;
            exit when Operator /= '*' and Operator /= '/';
            Get (Operator);
            if Operator = '*' then
                Value := Value * Primary;
            else
                Value := Value / Primary;
            end if;
        end loop;
        return Value;
    end Term;

    function Primary return Integer is
        Value : Integer;
        Ch    : Character;
    begin
        Ch := Next_Character;
        case Ch is
            when '0'..'9' =>
                Get (Value);
            when '(' =>
                Get (Ch);
                Value := Expression;
                if Next_Character /= ')' then
                    raise Syntax_Error;
                else
                    Get (Ch);
                end if;
            when others =>
                raise Syntax_Error;
        end case;
        return Value;
    end Primary;
end JE.Parser;
