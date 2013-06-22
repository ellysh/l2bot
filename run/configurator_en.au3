global const $kParamCount = 19
global const $kTipText[$kParamCount] = [ _
	"1. Specify left-up point of the target window", _
	"2. Specify right-bottom point of the target window", _
	"3. Specify first random point with the specific color of target window", _
	"4. Specify second random point with the specific color of target window", _
	"5. Specify left-up point of the target's HP bar", _
	"6. Specify right-bottom point of the target's HP bar", _
	"7. Specify point with color of the target's full HP bar", _
	"8. Specify left-up point of the target's MP bar (select yourself)", _
	"9. Specify right-bottom point of the target's MP bar (select yourself)", _
	"10. Specify point with color of the target's full MP bar (select yourself)", _
	"11. Specify point with color of the target's empty MP bar (select yourself)", _
 	"12. Specify left-up point of player's HP bar", _
 	"13. Specify right-bottom point of player's HP bar", _
	"14. Specify point with color of the player's full HP", _	
	"15. Specify left-up point of player's MP bar", _
	"16. Specify right-bottom point of player's MP bar", _
	"17. Specify point with color of the player's full MP", _
	"18. Specify left-up point of the map window", _
	"19. Specify right-bottom point of the map window" _
]

global const $kParamNames[$kParamCount] = [ _
	"kTargetWindowLeft", _
	"kTargetWindowRight", _
	"kTargetWindowColorBrown", _
	"kTargetWindowColorGray", _	
	"kTargetHealthLeft", _
 	"kTargetHealthRight", _
 	"kTargetHealthColor", _
 	"kTargetManaLeft", _
 	"kTargetManaRight", _
 	"kTargetManaColor", _
 	"kTargetManaEmptyColor", _
 	"kSelfHealthLeft", _
 	"kSelfHealthRight", _
 	"kSelfHealthColor", _
 	"kSelfManaLeft", _	
 	"kSelfManaRight", _	
 	"kSelfManaColor", _	
	"kMapWindowLeft", _
	"kMapWindowRight" _
]

global const $kConfigFile = "../conf/interface.au3"

#include "../source/configurator.au3"
