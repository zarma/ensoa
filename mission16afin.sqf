//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
// _null = execVM "mission16afin.sqf"
//////////////////////////////////////////////////////////////////
//diag_log text ""; 

player setVariable ["shootingComplete", true, true];
_targets = Z_Targets_RiflesClose;
//--------------------------------------------------------------------------------------------------
// PUP-UP THE TARGETS
//--------------------------------------------------------------------------------------------------
{
	_x removeAllEventHandlers "hit";
	_x animate ["terc",0];
	_x allowDamage true;
} forEach _targets;

sleep 8;
hint "Session Complete";	
{
	_x animate ["terc",1];
} forEach _targets;
