//////////////////////////////////////////////////////////////////
// Function file for Armed Assault 2
// Template for ACE
// Created by: =[A*C]= Z
//////////////////////////////////////////////////////////////////
//diag_log text ""; 

//passed array: [unit, killer]
Z_handler_targetKilled = {
	private["_target","_killed","_killLimit"];		
	_target = _this select 0;
	_target allowDamage false;
	_killed = player getVariable "killed";
	_killed = _killed + 1;
	//limit current kills to max. kills and set training as completed
	_killLimit = player getVariable "killLimit";
	hint format["|===Killed =   %1   ===|", _killed];
	if (_killLimit > 0 && _killed >= _killLimit) then {
		_killed = _killLimit;			
		player setVariable ["shootingComplete", true, false]; 
		hint format["|===Bravo killed =   %1   ===|", _killed];
	};
	player setVariable ["killed", _killed, false]; 	
};