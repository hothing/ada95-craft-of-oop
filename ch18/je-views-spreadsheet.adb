----------------------------------------------------------------------------
--
--   File:    je-views-spreadsheet.adb
--   Purpose: User interface package (body) for spreadsheet program
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling;
package body JE.Views.Spreadsheet is
    use JE.Spreadsheets;

    function Next_Command return Command_Type is
        Command : Character;
    begin
        loop
            New_Line;
            Put ("(M)odify, (D)isplay or (Q)uit: ");
            Get (Command);
            Skip_Line;
            case Command is
                when 'M' | 'm' =>
                    return Modify;
                when 'D' | 'd' =>
                    return Display;
                when 'Q' | 'q' =>
                    return Quit;
                when others =>
                    Put_Line ("Invalid command -- please enter M, D or Q.");
            end case;
        end loop;
    end Next_Command;

    procedure Display (Sheet : in out Sheet_Type) is
    begin
        Display (Sheet.Innards);
    end Display;

    procedure Display (Sheet : in out Sheet_Extension) is
        Screen_Width  : constant := 80;
        Screen_Length : constant := 25;
        Right_Margin  : constant := 1;
        Column_Width  : constant := 12;
        Column_Count  : constant := (Screen_Width - Right_Margin) / Column_Width;
        Left_Margin   : constant := Screen_Width - Right_Margin
                                                - (Column_Count * Column_Width);
        Top_Margin    : constant := 1;
        Bottom_Margin : constant := 4;
        Row_Count     : constant := Screen_Length - Top_Margin - Bottom_Margin;

        Column   : Character;
        Cell_Ptr : Cell_Access;
        Width    : Integer;
    begin
        Recalculate (Sheet);
        New_Line (Screen_Length);       -- clear screen by scrolling up
        Set_Col (Left_Margin);
        Column := 'A';
        for I in 0 .. Column_Count-1 loop
            Set_Col (Positive_Count(Left_Margin + I*Column_Width + 1));
            Put (Column);
            Column := Character'Succ(Column);
        end loop;
        New_Line;
        for R in 1 .. Row_Count loop
            Put (R, Width => Left_Margin-2);
            Put (":");
            Column := 'A';
            for C in 0 .. Column_Count-1 loop
                declare
                    Row : String := Integer'Image(R);
                begin
                    Set_Col (Positive_Count(Left_Margin + C*Column_Width + 1));
                    Cell_Ptr := Cell (Sheet, Column & Row(2..Row'Last));
                    if Cell_Ptr /= null then
                        Width := Integer'Min (Column_Width - 1,
                                              Text_Value(Cell_Ptr.all)'Length);
                        Put (Text_Value(Cell_Ptr.all)(1..Width));
                    end if;
                    Column := Character'Succ(Column);
                end;
            end loop;
            New_Line;
        end loop;
    end Display;

    procedure Modify (Sheet : in out Sheet_Type) is
        Name      : String(1..10);
        Name_Size : Natural;
        Line      : String(1..50);
        Line_Size : Natural;
        Which     : Cell_Access;
    begin
        Put ("Cell coordinate: ");
        Get_Line (Name, Name_Size);
        Which := Cell (Sheet.Innards, Name(1..Name_Size));
        Put ("Current value of " & Name(1..Name_Size) & ": ");
        if Which = null then                            -- empty cell
            Put ("<empty>");
        else
            if Which.all in String_Cell_Type'Class then
                Put ('"');                              -- string cell
            end if;
            Put (Contents (Which.all));
        end if;
        New_Line;
        Put ("Enter new value: ");
        Get_Line (Line, Line_Size);
        if Line_Size > 0 then                           -- new value entered
            case Line(1) is
                when ';' =>                             -- empty cell
                    Delete (Sheet.Innards, Name(1..Name_Size));
                when '"' =>                             -- string cell
                    Insert (Sheet.Innards, Name(1..Name_Size),
                            String_Cell (Sheet.Innards'Access,
                                         Line(2..Line_Size)) );
                when others =>                          -- formula cell
                    Insert (Sheet.Innards, Name(1..Name_Size),
                            Formula_Cell (Sheet.Innards'Access,
                                          Line(1..Line_Size)) );
            end case;
            Display (Sheet);
        end if;
    end Modify;
end JE.Views.Spreadsheet;
