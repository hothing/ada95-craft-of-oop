----------------------------------------------------------------------------
--
--   File:    je-spreadsheets.ads
--   Purpose: Spreadsheet package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Finalization, Ada.Exceptions, JE.Lists, JE.Pointers;
use  Ada.Finalization;
package JE.Spreadsheets is
    type Spreadsheet_Type   is abstract tagged limited private;

    type Cell_Type (Sheet : access Spreadsheet_Type'Class)
                            is abstract tagged limited private;
    type Formula_Cell_Type (Sheet : access Spreadsheet_Type'Class;
                            Size  : Natural)
                            is new Cell_Type with private;
    type String_Cell_Type  (Sheet : access Spreadsheet_Type'Class;
                            Size  : Natural)
                            is new Cell_Type with private;

    type Cell_Access        is access Cell_Type'Class;

    function  Formula_Cell (Sheet : access Spreadsheet_Type;
                            Value : String) return Cell_Access;
    function  String_Cell  (Sheet : access Spreadsheet_Type;
                            Value : String) return Cell_Access;

    procedure Evaluate     (Cell  : in out Cell_Type) is abstract;
    function  Text_Value   (Cell  : Cell_Type) return String is abstract;
    function  Contents     (Cell  : Cell_Type) return String is abstract;
    function  Num_Value    (Cell  : Cell_Type) return Integer is abstract;

    procedure Recalculate  (Sheet : in out Spreadsheet_Type);
    procedure Display      (Sheet : in out Spreadsheet_Type) is abstract;
    procedure Change       (Sheet : in out Spreadsheet_Type);
    function  Changed      (Sheet : Spreadsheet_Type) return Boolean;
    function  Cell         (Sheet : Spreadsheet_Type;
                            Where : String) return Cell_Access;
    procedure Delete       (Sheet : in out Spreadsheet_Type;
                            Where : in String);
    procedure Insert       (Sheet : in out Spreadsheet_Type;
                            Where : in String;
                            What  : in Cell_Access);

    Cell_Name_Length     : constant := 6;
    Circularity_Error    : exception;
    Undefined_Cell_Error : exception;

private
    type Cell_State_Type   is (Unknown, Defined, Undefined,
                               Evaluating, Error);
    type Evaluation_Number is mod 2;

    type Cell_Type (Sheet : access Spreadsheet_Type'Class) is
        abstract new Limited_Controlled with
        record
            State : Cell_State_Type := Unknown;
            Eval  : Evaluation_Number;
        end record;

    type Formula_Cell_Type (Sheet : access Spreadsheet_Type'Class;
                            Size  : Natural) is new Cell_Type(Sheet) with
        record
            Text  : String(1..Size);
            Value : Integer;
        end record;

    procedure Evaluate   (Cell : in out Formula_Cell_Type);
    function  Text_Value (Cell : Formula_Cell_Type) return String;
    function  Contents   (Cell : Formula_Cell_Type) return String;
    function  Num_Value  (Cell : Formula_Cell_Type) return Integer;

    type String_Cell_Type  (Sheet : access Spreadsheet_Type'Class;
                            Size  : Natural) is new Cell_Type(Sheet) with
        record
            Text  : String(1..Size);
        end record;

    procedure Evaluate   (Cell : in out String_Cell_Type);
    function  Text_Value (Cell : String_Cell_Type) return String;
    function  Contents   (Cell : String_Cell_Type) return String;
    function  Num_Value  (Cell : String_Cell_Type) return Integer;

    subtype Cell_Size     is Natural range 0 .. Cell_Name_Length;
    package Cell_Pointers is new JE.Pointers (Cell_Type'Class, Cell_Access);

    type Cell_Record is
        record
            Where : String (1..Cell_Name_Length);
            Size  : Cell_Size;
            Cell  : Cell_Pointers.Pointer_Type;
        end record;

    package Cell_Lists is new JE.Lists (Cell_Record);

    type Spreadsheet_Type is
        abstract tagged limited record
            Cells : Cell_Lists.List_Type;
            Dirty : Boolean := False;
            Eval  : Evaluation_Number := Evaluation_Number'First;
        end record;

    procedure Updated      (Sheet : in out Spreadsheet_Type);
    procedure Handle_Error (Sheet : access Spreadsheet_Type;
                            Error : in Ada.Exceptions.Exception_Occurrence);
    function  Evaluation   (Sheet : Spreadsheet_Type) return Evaluation_Number;
end JE.Spreadsheets;
