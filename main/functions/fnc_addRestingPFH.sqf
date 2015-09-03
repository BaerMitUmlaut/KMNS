/*
 * Author: BaerMitUmlaut
 * Adds a PFH when a unit enters a resting area.
 *
 * Arguments:
 * 0: The resting speed <NUMBER>
 * 1: The maximum regain cap <NUMBER>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [1/300, 1] call kmns_main_fnc_addRestingPFH
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_speed", "_cap"];

if (isNil QGVAR(handleRestingPFH)) then {
	GVAR(handleRestingPFH) = [FUNC(pfhResting), 1, [_speed, _cap]] call CBA_fnc_addPerFrameHandler;
};