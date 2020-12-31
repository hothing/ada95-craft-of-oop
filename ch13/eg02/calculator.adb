----------------------------------------------------------------------------
--
--   File:    calculator.adb
--   Purpose: Calculator program which recognises parentheses
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

    Operator    : Character;
    Operand     : Integer;
    Line_End    : Boolean;
    Got_Operand : Boolean := False;

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
            when '#' | '(' => return 0;
            when others    => raise Operator_Error;
        end case;
    end Prio;

begin           -- main program

    Push (Operator_Stack, '#');
    Put ("Enter an expression: ");

    loop
        -- Get next non-space character
        loop
            Look_Ahead (Operator, Line_End);
            if Line_End then                    -- treat end-of-line as end
                Operator := ';';                -- of expression
            end if;
            exit when Operator /= ' ';      -- exit loop if non-space found
            Get (Operator);                 -- otherwise skip the space
        end loop;

        -- Process operator or operand
        if Operator in '0'..'9' then        -- it's an operand

            if Got_Operand then             -- can't have an operand
                Put ("Missing operator");   -- immediately after another
                exit;
            end if;
            Get (Operand);                  -- read the operand
            Push (Operand_Stack, Operand);
            Got_Operand := True;            -- record we've got an operand

        else                                -- it's not an operand

            Got_Operand := False;           -- so record the fact
            exit when Operator = ';';       -- exit at end of expression
            Get (Operator);                 -- read the operator

            case Operator is
                when '+' | '-' | '*' | '/' =>
                    while Prio(Operator) <= Prio(Top(Operator_Stack)) loop
                        Apply;
                    end loop;
                    Push (Operator_Stack, Operator);

                when '(' =>                 -- just stack left parenthesis
                    Push (Operator_Stack, Operator);

                when ')' =>                 -- unwind stack back to '('
                    while Prio(Top(Operator_Stack)) > Prio('(') loop
                        Apply;
                    end loop;
                    Pop (Operator_Stack, Operator);
                    if Operator /= '(' then
                        Put ("Missing left parenthesis");
                        exit;
                    end if;

                when others =>
                    Put ("Invalid operator '");
                    Put (Operator);
                    Put ("'");
                    exit;
            end case;

        end if;

    end loop;

    if Operator = ';' then
        while Prio(Top(Operator_Stack)) > Prio('#') loop
            Apply;
        end loop;

        if Top(Operator_Stack) = '#' then
            Put (Top(Operand_Stack), Width => 1);
        else
            Put ("Missing right parenthesis");
        end if;
    end if;

    New_Line;
end Calculator;
