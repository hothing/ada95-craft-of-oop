----------------------------------------------------------------------------
--
--   File:    je-spreadsheets-active.adb
--   Purpose: Active (multitasking) spreadsheet package (body)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Calendar;
package body JE.Spreadsheets.Active is
    use type Ada.Calendar.Time;             -- to allow use of "+"

    function Counting_Cell (Sheet : access Spreadsheet_Type'Class)
                            return Cell_Access is
        Cell : Cell_Access := new Counting_Cell_Type (Sheet);
    begin
        return Cell;
    end Counting_Cell;

    task body Counter_Task is
        type Count_Type is mod 10000;
        Count       : Count_Type := Count_Type'First;
        Update_Time : Ada.Calendar.Time := Ada.Calendar.Clock + 5.0;
    begin
        loop
            select
                accept Get (Value : out Integer) do
                    Value := Integer(Count);
                end Get;
            or
                accept Stop;
                exit;
            or
                delay until Update_Time;
                Update_Time := Update_Time + 5.0;
                Count := Count + 1;
                Change (Sheet.all);
            end select;
        end loop;
    end Counter_Task;

    protected body Shared_Flag_Type is
        function State return Boolean is
        begin
            return State_Flag;
        end State;

        procedure Set is
        begin
            State_Flag := True;
        end Set;

        procedure Clear is
        begin
            State_Flag := False;
        end Clear;
    end Shared_Flag_Type;

    procedure Change (Sheet : in out Active_Spreadsheet_Type) is
    begin
        Sheet.Modified.Set;
    end Change;

    procedure Updated (Sheet : in out Active_Spreadsheet_Type) is
    begin
        Sheet.Modified.Clear;
    end Updated;

    function Changed (Sheet : Active_Spreadsheet_Type) return Boolean is
    begin
        return Sheet.Modified.State;
    end Changed;

    procedure Finalize (Object : in out Counting_Cell_Type) is
    begin
        Object.Counter.Stop;
    end Finalize;

    function Contents (Cell : Counting_Cell_Type) return String is
    begin
        return "<5-second counter>";
    end Contents;

    function Text_Value (Cell : Counting_Cell_Type) return String is
    begin
        return Integer'Image(Num_Value(Cell));
    end Text_Value;

    function Num_Value (Cell : Counting_Cell_Type) return Integer is
        I : Integer;
    begin
        Cell.Counter.Get (I);
        return I;
    end Num_Value;

    procedure Evaluate (Cell : in out Counting_Cell_Type) is
    begin
        Cell.State := Defined;
    end Evaluate;

end JE.Spreadsheets.Active;
