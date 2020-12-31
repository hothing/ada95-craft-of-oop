----------------------------------------------------------------------------
--
--   File:    je-parser.ads
--   Purpose: Simple expression parser (specification)
--   Author:  John English (je@brighton.ac.uk)
--
--   This code is from "Ada 95: The Craft of Object-Oriented Programming"
--   by John English (Prentice Hall 1997). Copyright (c) John English.
--   Permission is granted to copy and distribute this file for
--   non-commercial use only.
--
----------------------------------------------------------------------------

package JE.Parser is
    function Next_Character return Character;
    function Expression return Integer;

    Syntax_Error : exception;
end JE.Parser;

