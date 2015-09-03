#include "script_component.hpp"

ADDON = false;

PREP(addRestingPFH);
PREP(moduleAdjust);
PREP(moduleRestingArea);
PREP(pfhMain);
PREP(pfhResting);
PREP(removeRestingPFH);
PREP(reset);

GVAR(enduranceConstant) = KMNS_BASE_CONSTANT;
GVAR(enduranceConstantOverwriteLevel) = 0;

ADDON = true;