//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// get out of a vehicle not tested
//////////////////////////////////////////////////////////////////

private [
	"_nbparameters",
	"_parameters",
	"_indexparameters",
	"_grp"
	];
_parameters = [
	"_grp"
	];

_indexparameters = 0;
_nbparameters = count _this;
{
	if (_indexparameters <= _nbparameters) then {
	call compile format["%1 = _this select %2;", _x, _indexparameters];
	};
	_indexparameters = _indexparameters + 1;
}foreach _parameters;


{
	format ["_x %1", _x] call z_smsg;
//	_x setCaptive true; 
	_x switchMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"; 	
}forEach _grp;

