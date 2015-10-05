/*
 * Author: BaerMitUmlaut
 * Sets the hard fatigue value.
 *
 * Arguments:
 * 0: The hard fatigue value [0..1]. <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [0.5] call kmns_main_fnc_set
 *
 * Public: Yes
 */

#include "script_component.hpp"
params ["_value"];

if (_value > 1 || {_value < 0}) exitWith {
    ["%1 is an inavlid hard fatigue value.", _value] call BIS_fnc_error;
};

GVAR(hardFatigue) = _value;
GVAR(previousFatigue) = _value;
