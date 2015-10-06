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
private ["_owner", "_adjustment", "_initialValue"];

_owner = _logic getVariable "Owner";
_adjustment = _logic getVariable "Adjustment";
_initialValue = _logic getVariable "Initial";

if (_adjustment <= 0) exitWith {
    ["%1 the fatigue adjustment value must be greater than 0.", _adjustment] call BIS_fnc_error;
};

if (_initialValue > 1 || {_initialValue < 0}) exitWith {
    ["The initial endurance value must be between 1 and 0."] call BIS_fnc_error;
};

switch (_owner) do {
    case 0: {
        if (GVAR(enduranceConstantOverwriteLevel) > 3) exitWith {};
        if (player in (synchronizedObjects _logic)) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 4;
        };
    };
    case 1: {
        if (GVAR(enduranceConstantOverwriteLevel) > 2) exitWith {};
        if (({_x in (units group player)} count (synchronizedObjects _logic)) > 0) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 3;
        };
    };
    case 2: {
        if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
        if (({(side _x) == (side group player)} count (synchronizedObjects _logic)) > 0) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 2;
        };
    };
    case 3: {
        if (GVAR(enduranceConstantOverwriteLevel) > 0) exitWith {};
        GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
        [1 - _initialValue] call FUNC(set);
        GVAR(enduranceConstantOverwriteLevel) = 1;
    };
    case 4: {
        if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
        if ((side group player) == west) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 2;
        };
    };
    case 5: {
        if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
        if ((side group player) == east) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 2;
        };
    };
    case 6: {
        if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
        if ((side group player) == independent) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 2;
        };
    };
    case 7: {
        if (GVAR(enduranceConstantOverwriteLevel) > 1) exitWith {};
        if ((side group player) == civilian) then {
            GVAR(enduranceConstant) = KMNS_BASE_CONSTANT / _adjustment;
            [1 - _initialValue] call FUNC(set);
            GVAR(enduranceConstantOverwriteLevel) = 2;
        };
    };
};
