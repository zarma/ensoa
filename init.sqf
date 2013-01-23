//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
//////////////////////////////////////////////////////////////////
DEBUG = true;
//Hint format ["Difficulty %1",Difficulty] ;
// permet de mettre le point de respawn au niveau du sol dans un batiment
"respawn_west" setMarkerPosLocal [markerPos "respawn_west" select 0, markerPos "respawn_west" select 1, 0];
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
hint  "BIS_fnc_init";
if (local player) then { call compile preprocessFileLineNumbers "init\initclient.sqf"; }; 
if (isServer) then { call compile preprocessFileLineNumbers "init\initserver.sqf"; };