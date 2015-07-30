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
 * [] call kmns_main_fnc_perFramHandler
 *
 * Public: No
 */

#include "script_component.hpp"
private ["_currentFatigue", "_newFatigue"];


if (isNil QGVAR(hardFatigue)) then {
	GVAR(hardFatigue) = 0;
	GVAR(previousFatigue) = 0;
};
if (!(alive player)) then {
	//Remove sprint blocker and PFH on players death, reset variables
	if (!(isNil QGVAR(handleSprintBlocker))) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(handleSprintBlocker)];
	};
	GVAR(hardFatigue) = 0;
	GVAR(previousFatigue) = 0;
	[GVAR(handlePFH)] call CBA_fnc_addPerFrameHandler;
} else {
	_currentFatigue = getFatigue player;
	_newFatigue = _currentFatigue;

	if (_currentFatigue < (0.2 * GVAR(hardFatigue))) then {
		//If player is rested, stop fatigue from going back to 0
		_newFatigue = (0.2 * GVAR(hardFatigue));
	} else {
		if (_currentFatigue > GVAR(previousFatigue)) then {
			//Add hard fatigue penalty when player is currently gaining fatigue
			if ((animationState player) in ["amovpercmevasraswrfldf", "amovpercmevaslowwlnrdf", "amovpercmevasraswpstdf", "amovpercmevasnonwbindf", "amovpercmevasnonwnondf"]) then {
				//Sprinting gets an even higher penalty
				_newFatigue = GVAR(previousFatigue) + (_currentFatigue - GVAR(previousFatigue)) * (1 + 0.5 * GVAR(hardFatigue)) * 1.5;
			} else {
				_newFatigue = GVAR(previousFatigue) + (_currentFatigue - GVAR(previousFatigue)) * (1 + 0.5 * GVAR(hardFatigue));
			};
		};

		GVAR(hardFatigue) = (GVAR(hardFatigue) + ((time - GVAR(lastAdjustment)) / 500 * _newFatigue)) min 1;

		//Block sprinting if hard fatigue is too high
		if ((GVAR(hardFatigue) > 0.8) && (isNil QGVAR(handleSprintBlocker))) then {
			GVAR(handleSprintBlocker) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
				if ((_this select 1) in (actionKeys "Turbo") && (vehicle player == player)) then {
					true
				} else {
					false
				};
			}];
		};
	};

	player setFatigue _newFatigue;
	GVAR(previousFatigue) = _newFatigue;
};

GVAR(lastAdjustment) = time;