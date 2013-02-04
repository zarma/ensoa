//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// Pop up targets on region
//////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};
private [
	"_args",
	"_marker",
	"_radius"
	];

	_parameters = [
	"_marker",
	"_radius"
	];

_indexparameters = 0;
_nbparameters = count _this;
if (_nbparameters < 2) exitWith { };
{
	if (_indexparameters <= _nbparameters) then {
	call compile format["%1 = _this select %2;", _x, _indexparameters];
	};
	_indexparameters = _indexparameters + 1;
}foreach _parameters;
	
if (isNil "_marker") exitWith { };
if (isNil "_radius") exitWith { };

_targets = nearestObjects [markerPos _marker, ["TargetBase"], _radius];
_targets;