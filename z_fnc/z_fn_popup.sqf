//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// Pop up targets on region
//////////////////////////////////////////////////////////////////

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
_args = _this select 3;
_nbparameters = count _args;
diag_log text format["|= z_fn_popup _this :  %1   ===|", _args];
if (_nbparameters < 2) exitWith { };
{
	if (_indexparameters <= _nbparameters) then {
	call compile format["%1 = _args select %2;", _x, _indexparameters];
	};
	_indexparameters = _indexparameters + 1;
}foreach _parameters;
	

if (isNil "_marker") exitWith { };
if (isNil "_radius") exitWith { };

_targets = nearestObjects [markerPos _marker, ["TargetBase"], _radius];
diag_log text format["|= z_fn_popup _targets :  %1   ===|", _targets];
//--------------------------------------------------------------------------------------------------
// PUP-UP THE TARGETS
//--------------------------------------------------------------------------------------------------
{
	_x animate ["terc",0];
	diag_log text format["|= _x animate  :  %1   ===|", _x];
} forEach _targets;