// distance de vue
viewDist = 2000;
setViewDistance(viewDist);

// terrain valeur par defaut pour multi
setTerrainGrid 25;

// Init units 
{removeAllWeapons _x;} forEach PlayableUnits;

// Init crates 
_null = [] execVM "crates\initcrates.sqf";

// INIT RADIO DEBUT
_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "View Distance - 100"; 
_trg setTriggerActivation ["ALPHA", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'if (viewDistance > 200) then { setViewDistance (viewDistance - 100); }; hintSilent format["View Distance: %1", viewDistance]', ""]; 

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "View Distance + 100"; 
_trg setTriggerActivation ["BRAVO", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'if (viewDistance < 10000) then { setViewDistance (viewDistance + 100); }; hintSilent format["View Distance: %1", viewDistance]', ""]; 


_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "Fix Headbug"; 
_trg setTriggerActivation ["CHARLIE", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
if (lifeState player == "UNCONSCIOUS") exitWith {};
_pos = getPosATL player;
_vcl = "Old_bike_TK_CIV_EP1" createVehicleLocal spawnPos;
player moveInDriver _vcl;
moveOut player;
player setPosATL _pos;
deleteVehicle _vcl;
player switchCamera "INTERNAL";
detach player;
', ""]; 

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "Unflip Vehicle"; 
_trg setTriggerActivation ["DELTA", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
_vehicle = vehicle player;
if (player != _vehicle) then {
	_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 0.5];
	_vehicle setVelocity [0,0,-0.5];
};
if (player == _vehicle) then {
	_objects = player nearEntities[["Car","Motorcycle","Tank"],5];
	{	
		if (count _objects > 0) then {		
			_x setPos [getPos _x select 0, getPos _x select 1, 0.5];
			_x setVelocity [0,0,-0.5];
		};
	} forEach _objects;
};
', ""]; 

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "No grass";
_trg setTriggerActivation ["GOLF", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'setTerrainGrid 50; hintSilent format["No grass"]', ""]; 

_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "Grass";
_trg setTriggerActivation ["HOTEL", "PRESENT", true]; 
_trg setTriggerStatements ["this", 'setTerrainGrid 25; hintSilent format["Grass on"]', ""]; 

if DEBUG then { 
	deleteVehicle _trg; 
	_trg = createTrigger ["EmptyDetector", position player]; 
	_trg setTriggerText "teleport"; 
	_trg setTriggerActivation ["INDIA", "PRESENT", true]; 
	_trg setTriggerStatements ["this", 'hint "Click on map to select teleport destination"; onMapSingleClick "player setPosATL _pos; onMapSingleClick """"; hint ""Teleported!"" " ',""]; 
}; 

showRadio true; 
// INIT RADIO FIN

