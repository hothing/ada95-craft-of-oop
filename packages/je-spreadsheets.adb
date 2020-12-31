----------------------------------------------------------------------------
--
--   File:    je-spreadsheets.adb
--   Purpose: Spreadsheet package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with JE.Expressions.Spreadsheet, Ada.Characters.Handling;
use  JE.Expressions.Spreadsheet, Ada.Characters.Handling;
package body JE.Spreadsheets is
    use Cell_Lists, Cell_Pointers;

    function Formula_Cell (Sheet : access Spreadsheet_Type;
                           Value : String) return Cell_Access is
        Cell : Cell_Access := new Formula_Cell_Type(Sheet, Value'Length);
    begin
        Formula_Cell_Type(Cell.all).Text := Value;
        return Cell;
    end Formula_Cell;

    function String_Cell (Sheet : access Spreadsheet_Type;
                          Value : String) return Cell_Access is
        Cell : Cell_Access := new String_Cell_Type(Sheet, Value'Length);
    begin
        String_Cell_Type(Cell.all).Text := Value;
        return Cell;
    end String_Cell;

    procedure Recalculate (Sheet : in out Spreadsheet_Type) is
        Iter : Cell_Lists.List_Iterator;
        Cell : Cell_Pointers.Pointer_Type;
    begin
        Sheet.Eval := Sheet.Eval + 1;       -- increment evaluation number
        if Changed(Spreadsheet_Type'Class(Sheet)) then
            Iter := First(Sheet.Cells);
            while Iter /= Last(Sheet.Cells) loop
                Cell := Value(Iter).Cell;
                Evaluate (Value(Cell).all);
                Iter := Succ(Iter);
            end loop;
            Updated (Spreadsheet_Type'Class(Sheet));
        end if;
    end Recalculate;

    procedure Change (Sheet : in out Spreadsheet_Type) is
    begin
        Sheet.Dirty := True;
    end Change;

    procedure Updated (Sheet : in out Spreadsheet_Type) is
    begin
        Sheet.Dirty := False;
    end Updated;

    function Changed (Sheet : Spreadsheet_Type) return Boolean is
    begin
        return Sheet.Dirty;
    end Changed;

    function Cell (Sheet : Spreadsheet_Type;
                   Where : String) return Cell_Access is
        Iter : Cell_Lists.List_Iterator := Cell_Lists.First(Sheet.Cells);
        Cell : Cell_Record;
    begin
        while Iter /= Cell_Lists.Last(Sheet.Cells) loop
            Cell := Cell_Lists.Value(Iter);
            exit when To_Upper(Cell.Where(1..Cell.Size)) = To_Upper(Where);
            Iter := Cell_Lists.Succ(Iter);
        end loop;
        if Iter /= Cell_Lists.Last(Sheet.Cells) then
            return Value(Cell_Lists.Value(Iter).Cell);
        else
            return null;
        end if;
    end Cell;

    procedure Delete (Sheet : in out Spreadsheet_Type;
                      Where : in String) is
        Iter : Cell_Lists.List_Iterator;
        Cell : Cell_Record;
    begin
        Iter := Cell_Lists.First (Sheet.Cells);
        while Iter /= Cell_Lists.Last (Sheet.Cells) loop
            Cell := Cell_Lists.Value(Iter);
            if To_Upper(Cell.Where(1..Cell.Size)) = To_Upper(Where) then
                Delete (Iter);
                Change (Spreadsheet_Type'Class(Sheet));
                exit;
            end if;
            Iter := Cell_Lists.Succ(Iter);
        end loop;
    end Delete;

    procedure Insert (Sheet : in out Spreadsheet_Type;
                      Where : in String;
                      What  : in Cell_Access) is
        New_Cell : Cell_Record;
    begin
        Delete (Sheet, Where);
        if What /= null then
            New_Cell.Size := Integer'Min(Cell_Name_Length,Where'Length);
            New_Cell.Where (1..New_Cell.Size) :=
                    Where (Where'First .. Where'First+New_Cell.Size-1);
            New_Cell.Cell := Pointer(What);
            Cell_Lists.Insert (Last(Sheet.Cells), New_Cell);
        end if;
        Change (Spreadsheet_Type'Class(Sheet));
    end Insert;

    function Evaluation (Sheet : Spreadsheet_Type) return Evaluation_Number is
    begin
        return Sheet.Eval;
    end Evaluation;

    function Text_Value (Cell : String_Cell_Type) return String is
    begin
        return Cell.Text;
    end Text_Value;

    function Contents (Cell : String_Cell_Type) return String is
    begin
        return Cell.Text;
    end Contents;

    procedure Evaluate (Cell  : in out String_Cell_Type) is
    begin
        Cell.State := Undefined;
    end Evaluate;

    function Num_Value (Cell : String_Cell_Type) return Integer is
    begin
        raise Undefined_Cell_Error;
        return 0;
    end Num_Value;

    function Text_Value (Cell : Formula_Cell_Type) return String is
    begin
        if Cell.State = Defined then
            return Integer'Image(Cell.Value);
        elsif Cell.State = Error then
            return "*ERROR*";
        else
            return "";
        end if;
    end Text_Value;

    function Contents (Cell : Formula_Cell_Type) return String is
    begin
        return Cell.Text;
    end Contents;

    function Num_Value (Cell : Formula_Cell_Type) return Integer is
    begin
        if Cell.State = Defined then
            return Cell.Value;
        else
            raise Undefined_Cell_Error;
        end if;
    end Num_Value;

    procedure Evaluate (Cell  : in out Formula_Cell_Type) is
        Expr : Formula_Type (Cell.Sheet);
    begin
        if Cell.State = Evaluating then
            raise Circularity_Error;
        elsif Cell.State = Unknown or
              Cell.Eval /= Evaluation(Cell.Sheet.all) then
            Cell.Eval  := Evaluation(Cell.Sheet.all);
            Cell.State := Evaluating;
            Cell.Value := Evaluate (Expr, Cell.Text);
            Cell.State := Defined;
        end if;
    exception
        when Undefined_Cell_Error =>
            if Cell.State /= Error then 
                Cell.State := Undefined;
            end if;
        when Fault : Circularity_Error | JE.Expressions.Syntax_Error
                                       | Constraint_Error =>
            Cell.State := Error;
            Handle_Error (Cell.Sheet, Fault);
    end Evaluate;

    procedure Handle_Error (Sheet : access Spreadsheet_Type;
                            Error : Ada.Exceptions.Exception_Occurrence) is
    begin
        null;       -- do nothing, but allow for future overriding
    end Handle_Error;
end JE.Spreadsheets;

