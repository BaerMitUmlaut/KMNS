/*
 * Author: BaerMitUmlaut
 * Adjusts the fatigue system based on the module settings.
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
private ["_owner", "_adjustment"];

_owner = _logic getVariable "Owner";
_adjustment = _logic getVariable "Adjustment";

switch (_owner) do {
	case 0: {
		if (GVAR(enduranceConstantOverwriteLevel) > 3) exitWith {};
		if (player in (synchronizedObjects _logic)) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 4;
		};
	};
	case 1: {
		if (GVAR(enduranceConstantOverwriteLevel) > 2) exitWith {};
		if (({_x in (units group player)} count (synchronizedObjects _logic)) > 0) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 3;
		};
	};
	case 2: {
		if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
		if (({(side _x) == (side group player)} count (synchronizedObjects _logic)) > 0) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 2;
		};
	};
	case 3: {
		if (GVAR(enduranceConstantOverwriteLevel) > 0) exitWith {};
		GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
		GVAR(enduranceConstantOverwriteLevel) = 1;
	};
	case 4: {
		if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
		if ((side group player) == west) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 2;
		};
	};
	case 5: {
		if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
		if ((side group player) == east) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 2;
		};
	};
	case 6: {
		if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
		if ((side group player) == independent) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 2;
		};
	};
	case 7: {
		if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
		if ((side group player) == civilian) then {
			GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
			GVAR(enduranceConstantOverwriteLevel) = 2;
		};
	};
};