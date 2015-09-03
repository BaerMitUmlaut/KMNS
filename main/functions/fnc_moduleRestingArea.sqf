/*
 * Author: BaerMitUmlaut
 * Creates a resting areas based on the modules settings.
 *
 * Arguments:
 * 0: The module <OBJECT>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [module] call kmns_main_fnc_moduleAdjust
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_logic"];
private ["_speed", "_cap"];

_speed = call compile (_logic getVariable "Speed");
_cap = _logic getVariable "Cap";

if ((_speed <= 0) || (_cap > 1) || (_cap <= 0)) exitWith {
	["%1 and/or %2 are invalid resting area parameters.", _speed, _cap] call BIS_fnc_error;
};

{
	if (_x isKindOf "EmptyDetector") then {
		private ["_trgOld", "_trgNew"];
		_trgOld = _x;
		_trgNew = createTrigger ["EmptyDetector", position _trgOld, false];
		_trgNew setTriggerArea (triggerArea _trgOld);
		_trgNew setTriggerActivation [str side player, "PRESENT", true];
		_trgNew setTriggerStatements [QUOTE(player in thisList), format [QUOTE([ARR_2(%1,%2)] call FUNC(addRestingPFH)), _speed, _cap], QUOTE([] call FUNC(removeRestingPFH))];
		diag_log [QUOTE(player in thisList), format [QUOTE([ARR_2(%1,%2)] call FUNC(addRestingPFH)), _speed, _cap], QUOTE([] call FUNC(removeRestingPFH))];
	};
} count (synchronizedObjects _logic);