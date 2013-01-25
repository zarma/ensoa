﻿//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
// _null = execVM "mission16a.sqf"
//////////////////////////////////////////////////////////////////
//diag_log text ""; 

//TODO à remplacer par call compile ?
//mission related stuff 
#include "mission_functions.sqf";
#include "mission_setup.sqf";

//--------------------------------------------------------------------------------------------------
// INIT MISSION
//--------------------------------------------------------------------------------------------------
player setVariable ["killed", 0, false];
player setVariable ["killLimit", 5, false];
_targets = Z_Targets_RiflesClose;

//--------------------------------------------------------------------------------------------------
// PUP-DOWN THE TARGETS
//--------------------------------------------------------------------------------------------------
{
	_x animate ["terc",1];
} forEach Z_Targets_RiflesClose;

sleep 1;

//--------------------------------------------------------------------------------------------------
// SHOOTING RANGE1
//--------------------------------------------------------------------------------------------------
player setVariable ["shootingComplete", false, false];
[Z_Targets_RiflesClose,2,2] spawn {
	private["_target","_targets","_targetsAll","_time2Wait","_time2Hit","_phase","_t","_tdelta"];
	
	//_targets = BIS_Targets_RiflesFar;
	_targetsAll = _this select 0;
	_targets = _this select 0;
	_time2Wait = _this select 1;
	_time2Hit = _this select 2;
	
	diag_log text format["|=_this==   %1   ===|", _this];
	{
		//_x addEventHandler ["killed", "_this call Z_handler_targetKilled"];
		_x addEventHandler ["hit", "_this call Z_handler_targetKilled"];
	
	} forEach (_targets);
	
	while {!(player getVariable "shootingComplete")} do {
	
		if((count _targets) == 0) then {
			hint "no more target";
			player setVariable ["shootingComplete", true, false]; 		
		} else {
			_tdelta = random(_time2Wait);
			_t = time;
			
			waitUntil{(time > _t + _tdelta)};
			
			_target = _targets call BIS_fnc_selectRandom;
			diag_log text format["|==_targets =   %1   ===|", _targets]; 
			diag_log text format["|==_target =   %1   ===|", _target]; 
			_targets = _targets - [_target];
			diag_log text format["|==_targets apr delete =   %1   ===|", _targets]; 
			_target animate ["terc",0];
			
			waitUntil{(_target animationPhase "terc" == 0)};

			_target allowDamage true;		
			_tdelta = random(_time2Hit)+2;
			_t = time;
		
			//waitUntil{_phase = _target animationPhase "terc"; (time > _t + _tdelta) || (_phase > 0)};
			waitUntil{(time > _t + _tdelta)};
			
			if (_target animationPhase "terc" == 0) then {
				_target allowDamage false;
				_target animate ["terc",1];
			};	
		};
	};	
	sleep 5;

	//--------------------------------------------------------------------------------------------------
	// PUP-UP THE TARGETS
	//--------------------------------------------------------------------------------------------------
	{
		_x removeAllEventHandlers "hit";
		_x animate ["terc",0];
		_x allowDamage false;
	} forEach _targetsAll;
	
	sleep 8;
	hint "Session Complete";
	{
		_x animate ["terc",1];
	} forEach _targetsAll;
};