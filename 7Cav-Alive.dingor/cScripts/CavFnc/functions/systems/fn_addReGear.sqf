#include "..\script_component.hpp";
/*
 * Author: CPL.Brostrom.A
 * This adds a reGear selection option. The script reApplyes the players start loadout. But may also heal you if option is allowed.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Allow Heal <BOOL>
 *
 * Example:
 * [this,true] call cScripts_fnc_addReGear
 */

params [
    ["_object", objNull, [objNull]],
    ["_doHeal", true]
];

// Make addAction
_object addAction ["   <t color='#ffcc33'>ReGear</t>", {
    params ["_target", "_caller", "_actionId", "_arguments"];
    _arguments params ["_doHeal"];
    private _loadout = _caller getVariable ["poppy_loadout", ""];
    [_caller, _loadout] call Poppy_fnc_applyLoadout;

    if (_doHeal) then {
        [_target, _caller] call ace_medical_treatment_fnc_fullHeal;
    };
}, [_doHeal], 1.5, true, true, "", "true", 5];

// Make ACE Interaction for ReGear
private _Icon = "cScripts\Data\Icon\icon_00.paa";
private _reGearCondition = {true};
private _reGearStatement = {
    private _loadout = player getVariable ["poppy_loadout", ""];
    [player, _loadout] call Poppy_fnc_applyLoadout;

    if (_doHeal) then {
        [_this select 0, player] call ace_medical_treatment_fnc_fullHeal;
    };
};
private _reGearAction = ["cScriptsReGearAce", "ReGear", _Icon, _reGearStatement, _reGearCondition] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _reGearAction] call ace_interact_menu_fnc_addActionToObject;
