/*
 * Author: BaerMitUmlaut
 * Calculates the penalty factor that gets added to the players fatigue.
 *
 * Arguments:
 * 0: Resting penalty <BOOL> (default: false)
 *
 * Return Value:
 * Penalty factor <NUMBER>
 *
 * Example:
 * [false] call kmns_main_fnc_calculatePenalty
 *
 * Public: No
 */

#include "script_component.hpp"
params [["_resting", false]];
private ["_penaltyFactor", "_heightASL", "_temperature"];

if (_resting) then {
    //By default, a unit is fully rested after 60 seconds
    //We increase this time depending on hard fatigue
    _penaltyFactor = 1 + 6 * GVAR(hardFatigue);
} else {
    //Generic faster increase
    _penaltyFactor = 1.25;
};

//Add hard fatigue penalty
_penaltyFactor = _penaltyFactor * (1 + 0.5 * GVAR(hardFatigue));

//Add altitude based fatigue
_heightASL = (getPosASL player) select 2;
if (_heightASL > 1500) then {
    _penaltyFactor = _penaltyFactor * (1 + (_heightASL - 1500) / 500);
};

//Add temperature based fatigue
_temperature = _heightASL call ace_weather_fnc_calculateTemperatureAtHeight;
if (_temperature > 30) then {
    _penaltyFactor = _penaltyFactor * (1 + ((_temperature - 30) / 10)^2);
};

//Add sprinting penality
if ((animationState player) in ["amovpercmevasraswrfldf", "amovpercmevaslowwlnrdf", "amovpercmevasraswpstdf", "amovpercmevasnonwbindf", "amovpercmevasnonwnondf"]) then {
    _penaltyFactor = _penaltyFactor * 1.5;
};

_penaltyFactor
