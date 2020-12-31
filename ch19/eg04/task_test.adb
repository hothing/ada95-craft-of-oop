----------------------------------------------------------------------------
--
--   File:    task_test.adb
--   Purpose: Demonstration of use of rendezvous to synchronise access
--            to a stack
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

with Ada.Text_IO, Ada.Numerics.Float_Random, Int_Stacks;
use  Ada.Text_IO;
procedure Task_Test is

    task Stack_Manager is
        entry Push (Item : in Integer);
        entry Pop  (Item : out Integer);
        entry Size (Item : out Integer);
    end Stack_Manager;

    task body Stack_Manager is
        Stack : Int_Stacks.Stack_Type;
    begin
        loop
            select
                accept Push (Item : in Integer) do
                    Int_Stacks.Push (Stack,Item);
                end Push;
            or
                when not Int_Stacks.Empty (Stack) =>
                accept Pop (Item : out Integer) do
                    Int_Stacks.Pop (Stack,Item);
                end Pop;
            or
                accept Size (Item : out Integer) do
                    Item := Int_Stacks.Size (Stack);
                end Size;
            or
                terminate;
            end select;
        end loop;
    end Stack_Manager;

    task Pusher;
    task Popper;

    task body Pusher is
        G : Ada.Numerics.Float_Random.Generator;
	S : Integer;
    begin
        Ada.Numerics.Float_Random.Reset (G);
        for I in 1..50 loop
	    delay Duration(Ada.Numerics.Float_Random.Random(G));
	    Put_Line ("Pushing...");
	    Stack_Manager.Push (1);
	    Stack_Manager.Size (S);
	    Put_Line ("Push complete, size =" & Integer'Image(S));
	end loop;
    end Pusher;

    task body Popper is
        G : Ada.Numerics.Float_Random.Generator;
	S : Integer;
    begin
        Ada.Numerics.Float_Random.Reset (G);
        for I in 1..50 loop
	    delay Duration(Ada.Numerics.Float_Random.Random(G));
	    Put_Line ("Popping...");
	    Stack_Manager.Pop (S);
	    Stack_Manager.Size (S);
	    Put_Line ("Pop complete, size =" & Integer'Image(S));
	end loop;
    end Popper;

begin
    null;
end Task_Test;
