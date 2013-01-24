//                 How to use. 
// 1. Place a popup target and name it to pt1 
// 2. copy it 8 times and it will auto name the targets
// 3. place this line in a trigger or init  nul=[max,set,time] execVM "popup.sqf" 
// max  is the total number of targets that will popup
// set is the max number of targets that can popup per set upto a max of 3
// time is the amount of time to hit the targets before they go down

  
_maxtarg  = _this select 0;
_numtargs = _this select 1;
_skill    = _this select 2;

_targets = [pt1,pt1_1, pt1_2, pt1_3, pt1_4, pt1_5, pt1_6, pt1_7];// target names 
_many    =  count _targets; // count the number of possible targets

_inc     = 0;// keeps track of the number of popup targets triggered 
_score   = 0;// keep count of the targets hit


{_x  animate["terc",1]} forEach _targets;//puts the targets down before the start

_rnumber1=0; 
_rnumber2=0;
_rnumber3=0;

_flag1=0;
_flag2=0;

nopop=true; // sets them to stay down until triggered to popup

hint "Setting up the Range";
sleep 2;
hint "Ready";
sleep 2;


while {_inc<_maxtarg} do 
{
_rnumber1 = random _many;
_int = _rnumber1%1;
_rnumber1 = _rnumber1-_int;


// 1. Check for duplicate targets 
while {(_rnumber1 == _rnumber2) or (_rnumber1 == _rnumber3) or (_rnumber2 == _rnumber3)} do
{  
_rnumber2 = random _many;
_int = _rnumber2%1;
_rnumber2 = _rnumber2-_int;

_rnumber3 = random _many;
_int = _rnumber3%1;
_rnumber3 = _rnumber3-_int;
};
// 1. END

// 2. Set the targets that will popup
_rtarget1 = _targets select _rnumber1;
_rtarget2 = _targets select _rnumber2;
_rtarget3 = _targets select _rnumber3;
// 2. END

// 3. Popup target one always active
_rtarget1 animate["terc", 0];
_inc=_inc+1;
// 3. END

// 3a. Check to see if more than one target is required and opopup at random
// 3b. second target
If (_numtargs > 1 ) then
{
if ((random 2 > 1) and (_inc < _maxtarg)) then
{
_rtarget2 animate["terc", 0];
_inc=_inc+1;
_flag1=1;
};
};
//3b. END

//3c. Third target
If (_numtargs > 2 ) then
{
if ((random 2 < 1) and (_inc < _maxtarg)) then
{
_rtarget3 animate["terc", 0];
_inc=_inc+1;
_flag2=1;
};
};
// 3c. END
// 3a. END

// 4. Time allowed for shooting.
sleep _skill; 
// 4. END 

// 5. Check to see if targets have been hit and count the score
 if (_rtarget1 animationPhase "terc" > 0.1) then
{
		_score = _score+1;
		    };
 if ((_rtarget2 animationPhase "terc" > 0.1) and (_flag1 == 1)) then

{
		_score = _score+1;
		    };
 if ((_rtarget3 animationPhase "terc" > 0.1) and (_flag2 == 1)) then
{
		_score = _score+1;
		    };
// 4. END		    

// 5. Display Score		    
 hint format ["Targets :%1 Hit :%2",_inc,_score];
// 5. END

// 6. Reset targets down and restet flags
_rtarget1 animate["terc", 1];
_rtarget2 animate["terc", 1];
_rtarget3 animate["terc", 1];
_flag1=0;
_flag2=0;
// 6. END

sleep 2;
};
sleep 8;
hint "Session Complete";