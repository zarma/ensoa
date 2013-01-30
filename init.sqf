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

// compilation des fonctions
ZF_stringToConfig  = compile preprocessFile "ca\modules\ambient_combat\data\scripts\functions\convertGroupStringToConfig.sqf";
// compilation des caisse
//ZF_popup  = compile preprocessFile"crates\popup";
// compilation des lessons
// ZF_popup  = compile preprocessFile"lessons\popup.sqf";
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
	diag_log text format["|===   %1   ===|", "initclient"]; 
	call compile preprocessFileLineNumbers "init\initclient.sqf";
	_stop = table_mout addAction["Lever les cibles","z_fnc\z_fn_popup.sqf",["Z_MrkTargets_Mout", 80]];	
}; 

//======= SERVER SIDE
//if (isServer) then { call compile preprocessFileLineNumbers "init\initserver.sqf"; };
if (isServer) then {
// ACE Modules
	diag_log text format["|===   %1   ===|", "initserver"];
	setDate [2010, Month, Day, Hour, Minute + (time/60)];	
}; // fin init server
