----------------------------------------------------------------------------
--
--   File:    task_test.adb
--   Purpose: Demonstration of task type with discriminants
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO;
use  Ada.Text_IO;
procedure Task_Test is
    task type Repeat (Count : Natural);

    task body Repeat is
    begin
        -- Discriminant determines number of iterations
        for I in 1..Count loop  
            Put_Line (Integer'Image(Count) & " Hello!");
            delay 2.0;
        end loop;
    end Repeat;

    A : Repeat (Count => 10);       -- this task says hello 10 times
    B : Repeat (Count => 5);        -- this one does it 5 times
begin
    null;
end Task_Test;
