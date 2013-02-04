//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Created by: =[A*C]= Z
// gestion des tirs sur cibles
//////////////////////////////////////////////////////////////////
private["_target","_killer","_killed","_killLimit","_targetno","_s"];	
diag_log text format["|= z_f_targetKilled _this :  %1   ===|", _this];	
//if (isServer) then {
	//passed array: [unit, killer]
	diag_log text format["|= _target animationPhase 'terc' % 1 ===|", (_target animationPhase "terc")];	
	_target = _this select 0;
	_killer = _this select 1;
	_killed = _killer getVariable "killed";
	_killed = _killed + 1;
	_targetno = _killer getVariable "targetno";
	//limit current kills to max. kills and set training as completed
	_killLimit = player getVariable "killLimit";
	_s = format["<t size='1.35' shadow='true' color='#3E0000'>Touchées</t><br/><t size='1.35' shadow='true' color='#3E0000'>%1 / %2</t>", _killed,_targetno];
	if (_killLimit > 0 && _killed >= _killLimit) then {
		_killed = _killLimit;			
		_killer setVariable ["shootingComplete", true, true]; 
		_s = format["<t size='1.35' shadow='true' color='#3E0000'>Terminé</t><br/><t size='1.35' shadow='true' color='#3E0000'>%1 / %2</t>", _killed,_targetno];
	};
	_killer setVariable ["killed", _killed, true]; 	
//};

[_s] spawn z_infoText;
