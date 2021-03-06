﻿//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// gestion des cibles mobiles
//////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};
private["_start","_end","_distance","_hoverHeight","_i","_pos","_posStart","_posEnd","_fsm","_t","_threads"];

//init
_start = _this select 0;
_end = _this select 1;
_speed = _this select 2;
_hoverHeight = _this select 3;
diag_log text format["|===  z_execMovingTarget this  %1   ===|", _this]; 
//show the path
_distance = round (_start distance _end);
diag_log text format["|===  _distance  %1   ===|", _distance]; 
_end setPosASL ([_start,_end,_distance] call BIS_getPosInDistance);

//re-position the start & end marker
_posStart = getPos _start;
_posStart = [_posStart select 0, _posStart select 1, _hoverHeight - 0.05];
_posEnd = getPos _end;
_posEnd = [_posEnd select 0, _posEnd select 1, _hoverHeight - 0.05];
_start setPos _posStart;
_end setPos _posEnd;

//create target
_dir =  [_start,player] call BIS_fnc_dirTo;
Z_GTarget = "TargetEpopup" createVehicle _posStart;
Z_GTarget setDir _dir;
Z_GTarget setPos [_pos select 0,_pos select 1,_hoverHeight];	

//add a handler
Z_GTarget addEventHandler ["HandleDamage", "_this call BIS_handler_SniperTargetHit2"];
Z_GTarget allowDamage true;

//["THREAD FINISHED","BIS_Thread_IsPaused"] call BIS_debugLog;		

//turn target
z_Thread_TurnTarget = [] spawn {
	while {!z_mission18aComplete} do {
		_dir = 180 + ([Z_GTarget,player] call BIS_fnc_dirTo);
		_pos = getPosASL Z_GTarget;
		
		Z_GTarget setDir _dir;
		Z_GTarget setPosASL _pos;
		
		sleep 1;
	};
	
	["THREAD FINISHED","z_Thread_TurnTarget"] call BIS_debugLog;
};

while {!z_mission18aComplete} do {

	//animate target
	[Z_GTarget,[_posStart,_posEnd],_speed,_speed,_hoverHeight] call BIS_animateObject;		
	
	//terminate the animation
	terminate (Z_GTarget getVariable "BIS_MainAnim_Spawn");
};

//remove handlers
Z_GTarget removeAllEventHandlers "HandleDamage";


//safe-check the threads
_t = time;

waitUntil{(time > _t + 1) || (scriptDone z_Thread_TurnTarget)};

if (time > _t + 1) then {
	//terminate remaining running threads
	if !(scriptDone z_Thread_TurnTarget) then {
		["THREAD 'z_Thread_TurnTarget' TERMINATED!"] call BIS_debugLog;
		terminate z_Thread_TurnTarget;
	};
} else {
	//["ALL THREADS FINISHED SUCCESSFULLY"] call BIS_debugLog;	
};		

sleep 1;

//hide target
call z_sniperTargetDelete;
