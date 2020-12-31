----------------------------------------------------------------------------
--
--   File:    calculator.adb
--   Purpose: Calculator using stacks to implement precedence
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, JE.Stacks;
use  Ada.Text_IO, Ada.Integer_Text_IO;
procedure Calculator is
    package Operand_Stacks  is new JE.Stacks (Integer);
    package Operator_Stacks is new JE.Stacks (Character);
    use Operand_Stacks, Operator_Stacks;

    Operand_Stack  : Operand_Stacks.Stack_Type;
    Operator_Stack : Operator_Stacks.Stack_Type;

    Operator : Character;
    Operand  : Integer;

    Operator_Error : exception;

    procedure Apply is
        Left, Right : Integer;
        Operator    : Character;
    begin
        Pop (Operand_Stack, Right);
        Pop (Operand_Stack, Left);
        Pop (Operator_Stack, Operator);
        case Operator is
            when '+' => Push (Operand_Stack, Left + Right);
            when '-' => Push (Operand_Stack, Left - Right);
            when '*' => Push (Operand_Stack, Left * Right);
            when '/' => Push (Operand_Stack, Left / Right);
            when others => raise Operator_Error;
        end case;
    end Apply;

    function Prio (Operator : Character) return Natural is
    begin
        case Operator is
            when '+' | '-' => return 1;
            when '*' | '/' => return 2;
            when '#'       => return 0;
            when others    => raise Operator_Error;
        end case;
    end Prio;

begin           -- main program
    Push (Operator_Stack, '#');
    Put ("Enter an expression: ");
    Get (Operand);
    Push (Operand_Stack, Operand);
    loop
        loop
            Get (Operator);
            exit when Operator /= ' ';
        end loop;
        exit when Operator = ';';
        case Operator is
            when '+' | '-' | '*' | '/' =>
                while Prio(Operator) <= Prio(Top(Operator_Stack)) loop
                    Apply;
                end loop;
                Push (Operator_Stack, Operator);
            when others =>
                Put ("Invalid operator '");
                Put (Operator);
                Put ("'");
                exit;
        end case;
        Get (Operand);
        Push (Operand_Stack, Operand);
    end loop;
    if Operator = ';' then
        while Top(Operator_Stack) /= '#' loop
            Apply;
        end loop;
        Put (Top(Operand_Stack), Width => 1);
    end if;
    New_Line;
end Calculator;
