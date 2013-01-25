//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// get out of a vehicle
// return the crew not tested
//////////////////////////////////////////////////////////////////

private [
	"_nbparameters",
	"_parameters",
	"_indexparameters",
	"_veh",
	"_crew"
	];
_parameters = [
	"_veh"
	];

_indexparameters = 0;
_nbparameters = count _this;
{
	if (_indexparameters <= _nbparameters) then {
	call compile format["%1 = _this select %2;", _x, _indexparameters];
	};
	_indexparameters = _indexparameters + 1;
}foreach _parameters;

_crew = crew _veh;
_crew allowGetIn false;
{
	 _x joi; 

	
}forEach _crew;
_pos = [_veh, 5, (getDir _veh)] call BIS_fnc_relPos;
leader (group (_crew select 0)) doMove _pos;
_crew
