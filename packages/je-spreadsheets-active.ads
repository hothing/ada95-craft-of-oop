----------------------------------------------------------------------------
--
--   File:    je-spreadsheets-active.ads
--   Purpose: Active (multitasking) spreadsheet package (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Spreadsheets.Active is
    use JE.Spreadsheets;

    type Active_Spreadsheet_Type is abstract new Spreadsheet_Type
                                    with private;
    
    procedure Change  (Sheet : in out Active_Spreadsheet_Type);
    function  Changed (Sheet : Active_Spreadsheet_Type) return Boolean;

    type Counting_Cell_Type (Sheet : access Spreadsheet_Type'Class) is
                                    new Cell_Type with private;

    function  Counting_Cell (Sheet : access Spreadsheet_Type'Class)
                             return Cell_Access;

    procedure Evaluate   (Cell : in out Counting_Cell_Type);
    function  Contents   (Cell : Counting_Cell_Type) return String;
    function  Text_Value (Cell : Counting_Cell_Type) return String;
    function  Num_Value  (Cell : Counting_Cell_Type) return Integer;

private
    protected type Shared_Flag_Type is
        function  State return Boolean;
        procedure Set;
        procedure Clear;
    private
        State_Flag : Boolean := False;
    end Shared_Flag_Type;

    type Active_Spreadsheet_Type is abstract new Spreadsheet_Type with
        record
            Modified : Shared_Flag_Type;
        end record;
    procedure Updated (Sheet : in out Active_Spreadsheet_Type);

    task type Counter_Task (Sheet : access Spreadsheet_Type'Class) is
        entry Get (Value : out Integer);
        entry Stop;
    end Counter_Task;

    type Counting_Cell_Type (Sheet : access Spreadsheet_Type'Class) is
                                            new Cell_Type(Sheet) with
        record
            Counter : Counter_Task(Sheet);
        end record;

    procedure Finalize (Object : in out Counting_Cell_Type);

end JE.Spreadsheets.Active;
