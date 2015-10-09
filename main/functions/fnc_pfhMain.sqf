/*
 * Author: BaerMitUmlaut
 * Handles the hard fatigue system penalties and value changes every frame.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kmns_main_fnc_pfhMain
 *
 * Public: No
 */

#include "script_component.hpp"
private ["_currentFatigue", "_newFatigue", "_penaltyFactor"];

if (isNil QGVAR(hardFatigue)) then {
    GVAR(hardFatigue) = 0;
    GVAR(previousFatigue) = 0;
};
if (!(alive player)) then {
    //Remove sprint blocker and PFH on players death, reset variables
    if (!(isNil QGVAR(handleSprintBlocker))) then {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(handleSprintBlocker)];
    };
    GVAR(handleSprintBlocker) = nil;
    GVAR(hardFatigue) = 0;
    GVAR(previousFatigue) = 0;
    [GVAR(handleMainPFH)] call CBA_fnc_removePerFrameHandler;
} else {
    _currentFatigue = getFatigue player;
    _newFatigue = _currentFatigue;

    if (_currentFatigue < (0.2 * GVAR(hardFatigue))) then {
        //If player is rested, stop fatigue from going back to 0
        _newFatigue = (0.2 * GVAR(hardFatigue));
    } else {
        if (_currentFatigue > GVAR(previousFatigue)) then {
            _penaltyFactor = [false] call FUNC(calculatePenalty);
            _newFatigue = GVAR(previousFatigue) + (_currentFatigue - GVAR(previousFatigue)) * _penaltyFactor;

            //Only increase hard fatigue when the player is not resting
            GVAR(hardFatigue) = (GVAR(hardFatigue) + ((time - GVAR(lastAdjustment)) / GVAR(enduranceConstant) * _newFatigue)) min 1;
        } else {
            _penaltyFactor = [true] call FUNC(calculatePenalty);
            _newFatigue = GVAR(previousFatigue) - (GVAR(previousFatigue) - _currentFatigue) / _penaltyFactor;
        };
    };

    //Block sprinting if hard fatigue is too high
    if ((GVAR(hardFatigue) > 0.8) && {(isNil QGVAR(handleSprintBlocker))}) then {
        GVAR(handleSprintBlocker) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
            if ((_this select 1) in (actionKeys "Turbo") && (vehicle player == player)) then {
                true
            } else {
                false
            };
        }];
    };
    //Unblock sprinting if hard fatigue is lower again
    if ((!(isNil QGVAR(handleSprintBlocker))) && {(GVAR(hardFatigue) < 0.8)}) then {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(handleSprintBlocker)];
        GVAR(handleSprintBlocker) = nil;
    };

    player setFatigue (_newFatigue min 1);
    GVAR(previousFatigue) = (_newFatigue min 1);
};

GVAR(lastAdjustment) = time;
