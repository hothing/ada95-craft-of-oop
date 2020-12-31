----------------------------------------------------------------------------
--
--   File:    task_test.adb
--   Purpose: Demonstration of use of protected record to synchronise
--            access to a stack
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

    protected Stack_Manager is
        procedure Push  (Item : in Integer);
        entry     Pop   (Item : out Integer);
        function  Top   return Integer;
        function  Size  return Natural;
        function  Empty return Boolean;
    private
        Stack : Int_Stacks.Stack_Type;
    end Stack_Manager;

    protected body Stack_Manager is
        procedure Push (Item : in Integer) is
        begin
            Int_Stacks.Push (Stack,Item);
        end Push;

        entry Pop (Item : out Integer) when not Int_Stacks.Empty (Stack) is
        begin
            Int_Stacks.Pop (Stack,Item);
        end Pop;

        function Top return Integer is
        begin
            return Int_Stacks.Top (Stack);
        end Top;

        function Size return Natural is
        begin
            return Int_Stacks.Size (Stack);
        end Size;

        function Empty return Boolean is
        begin
            return Int_Stacks.Empty (Stack);
        end Empty;
    end Stack_Manager;

    task Pusher;
    task Popper;

    task body Pusher is
        G : Ada.Numerics.Float_Random.Generator;
    begin
        Ada.Numerics.Float_Random.Reset (G);
        for I in 1..50 loop
	    delay Duration(Ada.Numerics.Float_Random.Random(G));
	    Put_Line ("Pushing...");
	    Stack_Manager.Push (1);
	    Put_Line ("Push complete, size =" &
                      Integer'Image(Stack_Manager.Size));
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
	    Put_Line ("Pop complete, size =" &
                      Integer'Image(Stack_Manager.Size));
	end loop;
    end Popper;

begin
    null;
end Task_Test;
