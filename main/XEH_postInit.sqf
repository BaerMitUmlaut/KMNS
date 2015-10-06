#include "script_component.hpp"

if (hasInterface) then {
    GVAR(handleMainPFH) = [FUNC(pfhMain), 0, []] call CBA_fnc_addPerFrameHandler;
};