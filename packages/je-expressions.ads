----------------------------------------------------------------------------
--
--   File:    je-expressions.ads
--   Purpose: Extensible recursive descent expression parser (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Pointers;
package JE.Expressions is
    type Expression_Type is tagged limited private;

    function Evaluate (Syntax : Expression_Type;
                       Expr   : String) return Integer;

    Syntax_Error : exception;

private
    type Priority_Type     is range 0..9;
    subtype Operator_Priority_Type
                           is Priority_Type range 1..Priority_Type'Last;
    type String_Access     is access String;

    type Expression_Type   is tagged limited null record;

    type Token_Type        is abstract tagged null record;
    type Token_Access      is access Token_Type'Class;
    package Token_Pointers is new JE.Pointers (Token_Type'Class,
                                               Token_Access);
    subtype Token_Pointer  is Token_Pointers.Pointer_Type;

    procedure Next_Token  (Syntax : in Expression_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Token  : in out Token_Pointer);
    procedure Fetch_Token (Syntax : in Expression_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Token  : in out Token_Pointer);
    procedure Parse       (Syntax : in Expression_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Prio   : in Priority_Type;
                           Result : out Integer;
                           Next   : in out Token_Pointer);
    procedure Get_Operand (Syntax : in Expression_Type;
                           Expr   : in String;
                           From   : in out Positive;
                           Result : out Integer;
                           Next   : in out Token_Pointer);

    type Left_Parenthesis  is new Token_Type with null record;
    type Right_Parenthesis is new Token_Type with null record;
    type End_Of_Expression is new Token_Type with null record;

    type Operand_Type is abstract new Token_Type with null record;
    function Value (Operand : Operand_Type) return Integer is abstract;

    type Number_Type (Value : Integer) is new Operand_Type with null record;
    function Value (Operand : Number_Type) return Integer;
    
    type Operator_Type is abstract new Token_Type with null record;
    function Priority (Operator : Operator_Type)
                    return Operator_Priority_Type is abstract;

    type Unary_Operator_Type is abstract new Operator_Type with null record;
    function Apply (Operator : Unary_Operator_Type;
                    Right    : Integer) return Integer is abstract;

    type Binary_Operator_Type is abstract new Operator_Type with null record;
    function Apply (Operator    : Binary_Operator_Type;
                    Left, Right : Integer) return Integer is abstract;

    type Variadic_Operator_Type is abstract new Binary_Operator_Type
                                                            with null record;
    function Unary_Priority (Operator : Variadic_Operator_Type)
                             return Operator_Priority_Type is abstract;
    function Apply (Operator    : Variadic_Operator_Type;
                    Left, Right : Integer) return Integer is abstract;
    function Apply (Operator    : Variadic_Operator_Type;
                    Right       : Integer) return Integer is abstract;

    type Multiplying_Operator_Type is abstract new Binary_Operator_Type
                                                    with null record;
    function Priority (Operator : Multiplying_Operator_Type)
                                            return Operator_Priority_Type;

    type Adding_Operator_Type is abstract new Variadic_Operator_Type
                                                    with null record;
    function Priority (Operator : Adding_Operator_Type)
                                            return Operator_Priority_Type;
    function Unary_Priority (Operator : Adding_Operator_Type)
                                            return Operator_Priority_Type;

    type Times_Operator is new Multiplying_Operator_Type with null record;
    function Apply (Operator    : Times_Operator;
                    Left, Right : Integer) return Integer;

    type Over_Operator is new Multiplying_Operator_Type with null record;
    function Apply (Operator    : Over_Operator;
                    Left, Right : Integer) return Integer;

    type Plus_Operator is new Adding_Operator_Type with null record;
    function Apply (Operator    : Plus_Operator;
                    Left, Right : Integer) return Integer;
    function Apply (Operator    : Plus_Operator;
                    Right       : Integer) return Integer;

    type Minus_Operator is new Adding_Operator_Type with null record;
    function Apply (Operator    : Minus_Operator;
                    Left, Right : Integer) return Integer;
    function Apply (Operator    : Minus_Operator;
                    Right       : Integer) return Integer;
end JE.Expressions;

