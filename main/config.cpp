#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.1;
        requiredAddons[] = {"ace_weather"};
        author[] = {"BaerMitUmlaut"};
        authorUrl = "https://github.com/BaerMitUmlaut";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
