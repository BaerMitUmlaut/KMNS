/*
 * Author: BaerMitUmlaut
 * Lowers the players hard fatigue whilst resting.
 *
 * Arguments:
 * 0: Speed and cap array <ARRAY>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [[1/300, 1]] call kmns_main_fnc_pfhResting
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_args"];
_args params ["_speed", "_cap"];

GVAR(hardFatigue) = (GVAR(hardFatigue) - _speed) max (1 - _cap);