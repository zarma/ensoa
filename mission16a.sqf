//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
// _null = [player] execVM "mission16a.sqf"
//////////////////////////////////////////////////////////////////
//diag_log text ""; 

//TODO à remplacer par call compile ?
//mission related stuff 
//#include "mission_functions.sqf";
#include "mission_setup.sqf";

//--------------------------------------------------------------------------------------------------
// INIT MISSION
//--------------------------------------------------------------------------------------------------
diag_log text format["|=_this==   %1   ===|", _this];
_player = _this select 0;
_killLimit = _this select 1;
_time2Hit = _this select 2;
_player setVariable ["killed", 0, true];
_player setVariable ["killLimit", _killLimit, true];
_player setVariable ["targetno", 0, true];
sleep 5;
if (isServer) then {
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
	_player setVariable ["shootingComplete", false, true];
	[Z_Targets_RiflesClose,2,_time2Hit,_player] spawn {
		private["_target","_targets","_targetsAll","_time2Wait","_time2Hit","_phase","_t","_tdelta","_targetno"];
		
		//_targets = BIS_Targets_RiflesFar;
		_targetsAll = _this select 0;
		_targets = _this select 0;
		_time2Wait = _this select 1;
		_time2Hit = _this select 2;
		_player = _this select 3;
		_targetno = 0;
		
		diag_log text format["|=_this==   %1   ===|", _this];
		{
			_x removeAllMPEventHandlers "MPhit";			
			_x addMPEventHandler ["MPhit", "_this call Z_handler_targetKilled"];
		
		} forEach (_targets);
		
		diag_log text format["|=(_player getVariable 'shootingComplete')==   %1   ===|", (_player getVariable "shootingComplete")];
		while {!(_player getVariable "shootingComplete")} do {
		
			if((count _targets) == 0) then {
				diag_log text format["|=_this==   %1   ===|", "no more target"];				
				_targets = _targetsAll;
			} else {
				diag_log text format["|=_this==   %1   ===|", "choise target"];
				_tdelta = random(_time2Wait);
				_t = time;
				
				waitUntil{(time > _t + _tdelta)};
				
				_target = _targets call BIS_fnc_selectRandom;
				//diag_log text format["|==_targets =   %1   ===|", _targets]; 
				//diag_log text format["|==_target =   %1   ===|", _target]; 
				_targets = _targets - [_target];
				//diag_log text format["|==_targets apr delete =   %1   ===|", _targets]; 
				_target animate ["terc",0];
				
				waitUntil{(_target animationPhase "terc" == 0)};

				_tdelta = random(_time2Hit)+2;
				_targetno = _targetno + 1;
				_player setVariable ["targetno", _targetno, true];
				_t = time;
			
				//waitUntil{_phase = _target animationPhase "terc"; (time > _t + _tdelta) || (_phase > 0)};
				waitUntil{(time > _t + _tdelta)};
				
				if (_target animationPhase "terc" == 0) then {
					_target animate ["terc",1];
				};	
			};
		};	
		sleep 5;

		//--------------------------------------------------------------------------------------------------
		// PUP-UP THE TARGETS
		//--------------------------------------------------------------------------------------------------
		{
			_x removeAllMPEventHandlers "MPhit";
			_x animate ["terc",0];
		} forEach _targetsAll;
		
		sleep 8;	
		{
			_x animate ["terc",1];
		} forEach _targetsAll;
		
		[format["|=  %1  =|", "terminé"]] spawn z_hint;
	};
};
