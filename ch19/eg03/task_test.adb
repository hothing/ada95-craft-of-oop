----------------------------------------------------------------------------
--
--   File:    task_test.adb
--   Purpose: Example of parameterised rendezvous
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
procedure Task_Test is
    task type Counter_Task is
        entry Get (Value : out Integer);
    end Counter_Task;

    task body Counter_Task is
        V : Integer := 0;
    begin
        loop
            select
                accept Get (Value : out Integer) do
                    Value := V;
                    V := V + 1;
                end Get;
                delay 2.0;
            or
                terminate;
            end select;
        end loop;
    end Counter_Task;

    C : Counter_Task;
    V : Integer;
begin
    for I in 1..10 loop
        C.Get (V);
        Put (V, Width=>4);
        New_Line;
    end loop;
end Task_Test;
