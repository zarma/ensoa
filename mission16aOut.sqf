//////////////////////////////////////////////////////////////////
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

player setVariable ["killed", 0, false];
player setVariable ["killLimit", 5, false];

_targets = forEach Z_Targets_RiflesClose;
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
[] spawn {
	private["_target","_targets","_phase","_t","_tdelta"];
	
	//_targets = BIS_Targets_RiflesFar;
	_targets = Z_Targets_RiflesClose;
	
	{
		//_x addEventHandler ["killed", "_this call Z_handler_targetKilled"];
		_x addEventHandler ["hit", "_this call Z_handler_targetKilled"];
	
	} forEach (_targets);
	
	while {!(player getVariable "shootingComplete")} do {
			
		_tdelta = random(2);
		_t = time;
		
		waitUntil{(time > _t + _tdelta)};
		
		_target = _targets call BIS_fnc_selectRandom;
		_targets = _targets - [_target];
		_target animate ["terc",0];
		
		waitUntil{(_target animationPhase "terc" == 0)};

		_target allowDamage true;
		
		_tdelta = random(2)+1;
		_t = time;
	
		//waitUntil{_phase = _target animationPhase "terc"; (time > _t + _tdelta) || (_phase > 0)};
		waitUntil{(time > _t + _tdelta)};
		
		if (_target animationPhase "terc" == 0) then {
			_target allowDamage false;
			_target animate ["terc",1];
		};
		
		if(count _targets > 0) {
			player setVariable ["shootingComplete", true, false]; 
		}
	};	
	sleep 5;

	//--------------------------------------------------------------------------------------------------
	// PUP-UP THE TARGETS
	//--------------------------------------------------------------------------------------------------
	{
		_x removeAllEventHandlers "hit";
		_x animate ["terc",0];
		_x allowDamage false;
	} forEach Z_Targets_RiflesClose;
	
	sleep 8;
	hint "Session Complete";	
	{
		_x animate ["terc",1];
	} forEach Z_Targets_RiflesClose;
};