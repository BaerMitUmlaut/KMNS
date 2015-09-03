class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class ArgumentsBaseUnits {
			class Units;
		};
		class ModuleDescription {
			class AnyPlayer;
		};
	};
	class GVAR(moduleAdjust): Module_F {
		author = "BearMitUmlaut";
		scope = 2;
		displayName = "Adjust endurance";
		category = "KMNS";
		icon = PATHTOF(UI\iconModuleSettings.paa);
		function = FUNC(moduleAdjust);
		isGlobal = 1;
		class Arguments {
			class Owner {
				displayName = "Adjust endurance of";
				description = "Selects which units endurance will be adjusted";
				typeName = "NUMBER";
				class values {
					class Unit {
						name = "$STR_A3_CfgVehicles_Module_F_ArgumentsBaseUnits_Units_values_Objects_0";
						value = 0;
					};
					class Group {
						name = "$STR_A3_CfgVehicles_Module_F_ArgumentsBaseUnits_Units_values_ObjectsAndGroups_0";
						value = 1;
					};
					class Side {
						name = "$STR_A3_CfgVehicles_ModuleTaskCreate_F_Arguments_Owner_values_Side_0";
						value = 2;
					};
					class All {
						name = "$STR_A3_CfgVehicles_ModuleTaskCreate_F_Arguments_Owner_values_All_0";
						value = 3;
						default = 1;
					};
					class West {
						name = "$STR_West";
						value = 4;
					};
					class East {
						name = "$STR_East";
						value = 5;
					};
					class Guer {
						name = "$STR_Guerrila";
						value = 6;
					};
					class Civ {
						name = "$STR_Civilian";
						value = 7;
					};
				};
			};
			class Adjustment {
				displayName = "Factor";
				description = "How much faster/slower the unit will lose endurance";
				typeName = "NUMBER";
				defaultValue = 1;
			};
		};
		class ModuleDescription: ModuleDescription {
			description = "Enables and adjust the KMNS endurance system.";
			sync[] = {"AnyPlayer"};
			class AnyPlayer: AnyPlayer {
				optional = 1;
			};
		};
	};
	class GVAR(moduleRestingArea): Module_F {
		author = "BearMitUmlaut";
		scope = 2;
		displayName = "Resting area";
		category = "KMNS";
		icon = PATHTOF(UI\iconModuleResting.paa);
		function = FUNC(moduleRestingArea);
		isGlobal = 1;
		class Arguments {
			class Speed {
				displayName = "Resting speed";
				description = "How much endurance a unit gains back in endurance per second. Default: 1/300 = 5 minutes.";
				typeName = "STRING";
				defaultValue = "1/300";
			};
			class Cap {
				displayName = "Maximum regain";
				description = "Caps the endurance the unit can regain by resting. 1 means the unit could become completly rested again.";
				typeName = "NUMBER";
				defaultValue = 1;
			};
		};
		class ModuleDescription: ModuleDescription {
			description = "Defines a resting area for units where they can regain some endurance.";
			sync[] = {"EmptyDetector"};
		};
	};
};