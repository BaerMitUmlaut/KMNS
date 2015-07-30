#include "script_component.hpp"

if (hasInterface) then {
	GVAR(handlePFH) = [FUNC(perFrameHandler), 0, []] call CBA_fnc_addPerFrameHandler;
};