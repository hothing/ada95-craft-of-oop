----------------------------------------------------------------------------
--
--   File:    calculator.adb
--   Purpose: Evaluate an expression from left to right (using exception
--            handling)
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
procedure Calculator is
    Result   : Integer;
    Operator : Character;
    Operand  : Integer;
begin
    Put ("Enter an expression: ");
    Get (Result);                                   -- 1
    loop                                            -- 2
        loop                                        -- 3
            Get (Operator);
            exit when Operator /= ' ';
        end loop;
        if Operator = ';'then                       -- 4
            Put (Result, Width => 1);
            exit;
        else
            Get (Operand);                          -- 5
            case Operator is
                when '+' =>
                    Result := Result + Operand;     -- 6
                when '-' =>
                    Result := Result - Operand;
                when '*' =>
                    Result := Result * Operand;     -- 7
                when '/' =>
                    Result := Result / Operand;
                when others =>
                    Put ("Invalid operator '");     -- 8
                    Put (Operator);
                    Put ("'");
                    exit;                           -- 9
            end case;
        end if;
    end loop;
    New_Line;
exception
    when Constraint_Error =>
        Put_Line ("Value out of range");
    when Data_Error =>
        Put_Line ("Error in input -- integer expected");
end Calculator;
