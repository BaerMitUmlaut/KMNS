/*
 * Author: BaerMitUmlaut
 * Resets the hard fatigue back to 0.
 *
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 *
 * Example:
 * [] call kmns_main_fnc_reset
 *
 * Public: Yes
 */

#include "script_component.hpp"

GVAR(hardFatigue) = 0;
GVAR(previousFatigue) = 0;