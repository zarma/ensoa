//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
// _null = execVM "mission18a.sqf"
//////////////////////////////////////////////////////////////////
//diag_log text ""; 

//TODO à remplacer par call compile ?
//mission related stuff 
#include "mission_functions.sqf";
#include "mission_setup.sqf";

player setVariable ["killed", 0, false];
player setVariable ["killLimit", 5, false];
z_mission16aComplete = false;

private["_i","_pos","_dir","_target"];
//--------------------------------------------------------------------------------------------------
// INIT TARGETS
//--------------------------------------------------------------------------------------------------
_dir = [z_WP_Sniper_Post,z_ZeroingLine_End] call BIS_fnc_dirTo;

_targets = [];

for "_i" from 1 to 5 do {
	_pos = [z_WP_Sniper_Post,z_ZeroingLine_End,_i * 100] call BIS_getPosInDistance;
	_target = "TargetEpopup" createVehicle [0,0,0];
	_target setDir _dir;
	_target setPos [_pos select 0,_pos select 1,0];
	_target animate ["terc",1];
	_targets = _targets + [_target];
};
//--------------------------------------------------------------------------------------------------
// SHOOTING: AT MOVING TARGETS
//--------------------------------------------------------------------------------------------------

[BIS_SniperTarget_2,BIS_SniperTarget_1,1,1.8] call z_execMovingTarget;

[BIS_SniperTarget_4,BIS_SniperTarget_3,1,2.1] call z_execMovingTarget;

[BIS_SniperTarget_6,BIS_SniperTarget_5,0.7,2.0] call z_execMovingTarget;