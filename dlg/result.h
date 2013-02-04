#include "def.h"
#define COLOR_LIGHTBROWN { 0.776, 0.749, 0.658, 1 } 
#define COLOR_HALF_BLACK { 0, 0, 0, 0.5 } 
#define COLOR_TRANSPARENT { 0, 0, 0, 0 } 
// ... 

class RscTitles
{
	titles[]={"info"};
	
	class info { 
		idd = 10100;
		movingEnable = 1;
		name="info";
		duration = 1000000000; 
		fadein=0;
		objects[] = {};
		controls[] = { infoMessage };
		onLoad = "uiNamespace setVariable ['zdisplay', _this select 0];";
		onunLoad = "uiNamespace setVariable ['zdisplay', objnull];";    
		class infoMessage { 
			idc = 10101;
			type = CT_STRUCTURED_TEXT; 
			style = ST_LEFT; 
			size = 0.018; 
			x = 0.911459 * safezoneW + safezoneX;
			y = 0.800928 * safezoneH + safezoneY;
			w = 0.086563 * safezoneW;
			h = 0.193889 * safezoneH;
			colorText[] = {0,0,1,1};
			colorBackground[] = {1,1,1,0.35};
			colorBackgroundActive[] = {1,1,1,1};
			text ="";
		 }; 
	};
};