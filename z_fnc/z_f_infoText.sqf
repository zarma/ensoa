disableSerialization;
3100 cutrsc ["info","plain"];
//--- Visualization
disableserialization;
_display = uinamespace getvariable "zdisplay";
_ctrl = _display displayctrl 10101;
_text= format["%1", _this select 0];
_ctrl ctrlSetStructuredText parseText _text;
_ctrl ctrlcommit 0.01;
sleep 5;

3100 cuttext ["","plain"];