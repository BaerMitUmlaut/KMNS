#include "script_component.hpp"

ADDON = false;

PREP(addRestingPFH);
PREP(calculatePenalty);
PREP(moduleAdjust);
PREP(moduleRestingArea);
PREP(pfhMain);
PREP(pfhResting);
PREP(removeRestingPFH);
PREP(reset);
PREP(set);

GVAR(enduranceConstant) = KMNS_BASE_CONSTANT;
GVAR(enduranceConstantOverwriteLevel) = 0;

ADDON = true;
