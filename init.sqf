//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
//////////////////////////////////////////////////////////////////
diag_log text ""; 
diag_log text format["|=============================   %1   =============================|", missionName]; // ARMA2OA.RPT
diag_log text "";
DEBUG = true;
//Hint format ["Difficulty %1",Difficulty] ;
// permet de mettre le point de respawn au niveau du sol dans un batiment
//"respawn_west" setMarkerPosLocal [markerPos "respawn_west" select 0, markerPos "respawn_west" select 1, 0];
if(DEBUG) then {onMapSingleClick "player setpos _pos";};

// initialisation des fonctions
ZF_stringToConfig  = compile preprocessFile "ca\modules\ambient_combat\data\scripts\functions\convertGroupStringToConfig.sqf";
nul=[] execVM "z_fnc\z_fn_chat.sqf";

// distance de vue
viewDist = 2000;
setViewDistance(viewDist);

// terrain sans herbe
setTerrainGrid 50;

// initialisation du briefing
nul=[] execVM "briefing.sqf";


centerW = createCenter west;
centerE = createCenter east;
centerG = createCenter resistance;
centerC = createCenter civilian;

//--- wait for init BIS Functions
waituntil {!isnil "BIS_fnc_init"};
// Read mission parameters
for "_i" from 0 to (count paramsArray - 1) do {
	missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
};

//======= CLIENT SIDE
if (local player) then {
	call compile preprocessFileLineNumbers "init\initclient.sqf";	
}; 

//======= SERVER SIDE
//if (isServer) then { call compile preprocessFileLineNumbers "init\initserver.sqf"; };
if (isServer) then {
// ACE Modules

	ace_sys_wounds_enabled = woundsEnabled;					publicVariable "ace_sys_wounds_enabled";											
	ace_sys_wounds_noai = false;							publicVariable "ace_sys_wounds_noai";
	ace_sys_wounds_all_medics = true;						publicVariable "ace_sys_wounds_all_medics";
	ace_sys_wounds_ai_movement_bloodloss = true;			publicVariable "ace_sys_wounds_ai_movement_bloodloss";
	ace_sys_wounds_player_movement_bloodloss = true;		publicVariable "ace_sys_wounds_player_movement_bloodloss";
	ace_sys_wounds_auto_assist = true;						publicVariable "ace_sys_wounds_auto_assist";
	ace_sys_aitalk_enabled = true;							publicVariable "ace_sys_aitalk_enabled";
	ace_sys_aitalk_radio_enabled = true;					publicVariable "ace_sys_aitalk_radio_enabled";
	ace_sys_aitalk_talkforplayer = false;					publicVariable "ace_sys_aitalk_talkforplayer";
	
// 
	setDate [2010, Month, Day, Hour, Minute + (time/60)];	

}; // fin init server
