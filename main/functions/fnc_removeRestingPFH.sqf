/*
 * Author: BaerMitUmlaut
 * Removes resting PFH when the unit exits the resting area.
 *
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 *
 * Example:
 * [] call kmns_main_fnc_removeRestingPFH
 *
 * Public: No
 */

#include "script_component.hpp"

if (!(isNil QGVAR(handleRestingPFH))) then {
    [GVAR(handleRestingPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(handleRestingPFH) = nil;
};