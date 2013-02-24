global const $kParamCount = 7
global const $kTipText[$kParamCount] = [ _
	"1. Specify left-up point of the Fishing window", _
	"2. Specify right-bottom point of the Fishing window", _
	"3. Specify first random point with the specific color of Fishing window", _
	"4. Specify second random point with the specific color of Fishing window", _
	"5. Specify left-up point of the fish's HP bar", _
	"6. Specify right-bottom point of the fish's HP bar", _	
	"7. Specify point with color of the fish's full HP bar" _
]

global const $kParamNames[$kParamCount] = [ _
	"kFishingWindowLeft", _
	"kFishingWindowRight", _
	"kFishingColor1", _
	"kFishingColor2", _	
	"kFishHealthLeft", _
 	"kFishHealthRight", _
 	"kFishHealthColor" _
]

global const $kConfigFile = "../conf/interface_fishing.au3"
global const $kIsMoveControlPos = false

#include "../source/configurator.au3"
