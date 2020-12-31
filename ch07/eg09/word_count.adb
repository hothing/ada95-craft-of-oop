----------------------------------------------------------------------------
--
--   File:    word_count.adb
--   Purpose: Count the number of words in a file
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
procedure Word_Count is
    File    : File_Type;
    Name    : String(1..80);
    Size    : Natural;
    Count   : Natural := 0;
    In_Word : Boolean := False;
    Char    : Character;
begin
    -- Open input file
    loop
        begin
            Put ("Enter filename: ");
            Get_Line (Name, Size);
            Open (File, Mode => In_File, Name => Name(1..Size));
            exit;
        exception
            when Name_Error | Use_Error =>
                Put_Line ("Invalid filename -- please try again.");
        end;
    end loop;

    -- Process file
    while not End_Of_File (File) loop
        -- The end of a line is also the end of a word
        if End_Of_Line (File) then
            In_Word := False;
        end if;

        -- Process next character
        Get (File, Char);
        if In_Word and Char = ' ' then
            In_Word := False;
        elsif not In_Word and Char /= ' ' then
            In_Word := True;
            Count := Count + 1;
        end if;
    end loop;

    -- Close file and display result
    Close (File);
    Put (Count);
    Put_Line (" words.");
end Word_Count;
