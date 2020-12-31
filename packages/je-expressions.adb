----------------------------------------------------------------------------
--
--   File:    je-expressions.adb
--   Purpose: Extensible recursive descent expression parser (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Exceptions, Ada.Integer_Text_IO;
package body JE.Expressions is
    use Token_Pointers;

    function Evaluate (Syntax : Expression_Type;
                       Expr   : String) return Integer is
        Token  : Token_Pointer;
        From   : Positive := Expr'First;
        Result : Integer;
    begin
        Parse (Expression_Type'Class(Syntax), Expr, From,
               Priority_Type'Last, Result, Token);
        if Value(Token).all not in End_Of_Expression'Class then
            Ada.Exceptions.Raise_Exception (Syntax_Error'Identity,
                        "Missing operator or left parenthesis");
        end if;
        return Result;
    end Evaluate;

    function Priority (Operator : Multiplying_Operator_Type)
                                                return Operator_Priority_Type is
    begin
        return 5;
    end Priority;

    function Priority (Operator : Adding_Operator_Type)
                                                return Operator_Priority_Type is
    begin
        return 6;
    end Priority;

    function Unary_Priority (Operator : Adding_Operator_Type)
                                                return Operator_Priority_Type is
    begin
        return 2;
    end Unary_Priority;

    function Apply (Operator    : Times_Operator;
                    Left, Right : Integer) return Integer is
    begin
        return Left * Right;
    end Apply;

    function Apply (Operator    : Over_Operator;
                    Left, Right : Integer) return Integer is
    begin
        return Left / Right;
    end Apply;

    function Apply (Operator    : Plus_Operator;
                    Left, Right : Integer) return Integer is
    begin
        return Left + Right;
    end Apply;

    function Apply (Operator    : Plus_Operator;
                    Right       : Integer) return Integer is
    begin
        return Right;
    end Apply;

    function Apply (Operator    : Minus_Operator;
                    Left, Right : Integer) return Integer is
    begin
        return Left - Right;
    end Apply;

    function Apply (Operator    : Minus_Operator;
                    Right       : Integer) return Integer is
    begin
        return -Right;
    end Apply;

    function Value (Operand : Number_Type) return Integer is
    begin
        return Operand.Value;
    end Value;

    procedure Next_Token (Syntax : in Expression_Type;
                          Expr   : in String;
                          From   : in out Positive;
                          Token  : in out Token_Pointer) is
    begin
        -- Find start of next token
        while From <= Expr'Last and then Expr(From) = ' ' loop
            From := From + 1;
        end loop;

        -- Check for end of expression
        if From > Expr'Last then
            Token := Pointer(new End_Of_Expression);
        else
            Fetch_Token (Expression_Type'Class(Syntax), Expr, From, Token);
        end if;
    end Next_Token;

    procedure Fetch_Token (Syntax : in Expression_Type;
                           Expr  : in String;
                           From  : in out Positive;
                           Token : in out Token_Pointer) is
    begin
        case Expr(From) is
            when '+' =>
                Token := Pointer(new Plus_Operator);
            when '-' =>
                Token := Pointer(new Minus_Operator);
            when '*' =>
                Token := Pointer(new Times_Operator);
            when '/' =>
                Token := Pointer(new Over_Operator);
            when '(' =>
                Token := Pointer(new Left_Parenthesis);
            when ')' =>
                Token := Pointer(new Right_Parenthesis);
            when '0'..'9' =>
                declare
                    Value : Integer;
                begin
                    Ada.Integer_Text_IO.Get (Expr(From..Expr'Last),
                                             Value, From);
                    Token := Pointer(new Number_Type(Value));
                end;
            when others =>
                Ada.Exceptions.Raise_Exception (Syntax_Error'Identity,
                    "Illegal character '" & Expr(From) & "'");
        end case;
        From := From + 1;
    end Fetch_Token;

    procedure Parse (Syntax : in Expression_Type;
                     Expr  : in String;
                     From  : in out Positive;
                     Prio  : in Priority_Type;
                     Result   : out Integer;
                     Next  : in out Token_Pointer) is
    begin
        if Prio = Priority_Type'First then
            Get_Operand (Expression_Type'Class(Syntax),
                         Expr, From, Result, Next);
        else
            declare
                Right : Integer;
                Op    : Token_Pointer;
            begin
                Parse (Syntax, Expr, From, Prio-1, Result, Op);
                while Value(Op).all in Binary_Operator_Type'Class and then
                    Priority(Binary_Operator_Type'Class(Value(Op).all)) = Prio
                loop
                    Parse (Syntax, Expr, From, Prio-1, Right, Next);
                    Result := Apply (Binary_Operator_Type'Class(Value(Op).all),
                                     Result, Right);
                    Op := Next;
                end loop;
                Next := Op;
            end;
        end if;
    end Parse;

    procedure Get_Operand (Syntax : in Expression_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Result : out Integer;
                           Next   : in out Token_Pointer) is
        Op : Token_Pointer;
    begin
        Next_Token (Expression_Type'Class(Syntax), Expr, From, Next);

        -- Operand
        if Value(Next).all in Operand_Type'Class then
            Result := Value (Operand_Type'Class(Value(Next).all));
            Next_Token (Expression_Type'Class(Syntax), Expr, From, Next);

        elsif Value(Next).all in Left_Parenthesis'Class then
            Parse (Expression_Type'Class(Syntax),
                   Expr, From, Priority_Type'Last, Result, Next);
            if Value(Next).all in Right_Parenthesis'Class then
                Next_Token (Expression_Type'Class(Syntax), Expr, From, Next);
            else
                Ada.Exceptions.Raise_Exception (Syntax_Error'Identity,
                            "Missing right parenthesis");
            end if;

        elsif Value(Next).all in Unary_Operator_Type'Class then
            Op := Next;
            Parse (Expression_Type'Class(Syntax), Expr, From,
                Priority (Unary_Operator_Type'Class(Value(Op).all)),
                Result, Next);
            Result := Apply (Unary_Operator_Type'Class(Value(Op).all),
                             Result);

        elsif Value(Next).all in Variadic_Operator_Type'Class then
            Op := Next;
            Parse (Expression_Type'Class(Syntax), Expr, From,
                   Unary_Priority (Variadic_Operator_Type'Class(Value(Op).all)),
                   Result, Next);
            Result := Apply (Variadic_Operator_Type'Class(Value(Op).all),
                             Result);

        elsif Value(Next).all in End_Of_Expression'Class then
            Ada.Exceptions.Raise_Exception (Syntax_Error'Identity,
                        "Expression incomplete");

        else
            Ada.Exceptions.Raise_Exception (Syntax_Error'Identity,
                        "Illegal token");
        end if;
    end Get_Operand;
end JE.Expressions;
