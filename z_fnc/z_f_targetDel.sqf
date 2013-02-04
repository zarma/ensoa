//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// gestion des cibles mobiles
//////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};
//hide the target
if !(isNil "z_GTarget") then {
	_pos = getPos Z_GTarget;
	_pos = [_pos select 0,_pos select 1,(_pos select 2) - 20];
	
	//re-position the target
	Z_GTarget setPos _pos;
};	
