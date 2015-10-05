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
private ["_currentFatigue", "_newFatigue", "_penaltyFactor", "_heightASL", "_temperature"];

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
			//Add hard fatigue penalty
            _penaltyFactor = 1 + 0.5 * GVAR(hardFatigue);
            //Add altitude based fatigue
            _heightASL = (getPosASL player) select 2;
            if (_heightASL > 1500) then {
                _penaltyFactor = _penaltyFactor * ((_heightASL - 1500) / 500);
            };
            //Add temperature based fatigue
            _temperature = _heightASL call ace_weather_fnc_calculateTemperatureAtHeight;
            if (abs(_temperature - 17.5) > 12.5) then {
                _penaltyFactor = _penaltyFactor * (1 + (abs(_temperature - 17.5) / 10));
            };
            //Add sprinting penality
			if ((animationState player) in ["amovpercmevasraswrfldf", "amovpercmevaslowwlnrdf", "amovpercmevasraswpstdf", "amovpercmevasnonwbindf", "amovpercmevasnonwnondf"]) then {
				_penaltyFactor = _penaltyFactor * 1.5;
			};

            _newFatigue = GVAR(previousFatigue) + (_currentFatigue - GVAR(previousFatigue)) * _penaltyFactor;
		};

		GVAR(hardFatigue) = (GVAR(hardFatigue) + ((time - GVAR(lastAdjustment)) / GVAR(enduranceConstant) * _newFatigue)) min 1;
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

	player setFatigue _newFatigue;
	GVAR(previousFatigue) = _newFatigue;
};

GVAR(lastAdjustment) = time;
