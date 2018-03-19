/*
 * Author: PabstMirror
 * Tests if unit can load a magazine into a static weapon.
 *
 * Arguments:
 * 0: Static Weapon <OBJECT>
 * 1: Turret Path <ARRAY>
 * 2: Player <OBJECT>
 * 3: Carryable Magazine <STRING>
 * 4: Weapon <STRING>
 * 5: Check if empty based on ace_setting <OPTIONAL><BOOL>
 *
 * Return Value:
 * <BOOL>
 *
 * Example:
 * [cursorTarget, [0], player, "ACE_100Rnd_127x99_ball_carryable", "HMG_M2", false] call ace_crewserved_fnc_canLoadMagazine
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_vehicle", "_turret", "_unit", "_carryMag", "_weapon", ["_checkIfEmpty", true]];
TRACE_6("canLoadMagazine",_vehicle,_turret,_unit,_carryMag,_weapon,_checkIfEmpty);

// handle disassembled or deleted
if ((isNull _vehicle) || {(_vehicle distance _unit) > 5}) exitWith {false}; 

private _canLoad = false;

// Verify unit has carry magazine
{
    if (_x == _carryMag) exitWith {_canLoad = true;};
} forEach (magazines _unit);


private _currentAmmo = ((magazinesAllTurrets _vehicle) select 1) select 2;
private _carryMagAmmo = getNumber(configFile >> "CfgMagazines" >> _carryMag >> "count");
private _maxMagazineAmmo = getNumber(configFile >> "CfgMagazines" >> ((_vehicle magazinesTurret _turret) select 0) >> "count");
_canLoad = (_currentAmmo + _carryMagAmmo) <= _maxMagazineAmmo;

_canLoad
