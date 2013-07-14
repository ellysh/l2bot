global const $kParamCount = 23
global const $kTipText[$kParamCount] = [ _
 	"1. Specify left-up point of player's HP bar", _
 	"2. Specify right-bottom point of player's HP bar", _
	"3. Specify point with color of the player's full HP", _
	"4. Specify left-up point of player's MP bar", _
	"5. Specify right-bottom point of player's MP bar", _
	"6. Specify point with color of the player's full MP", _
 	"7. Specify left-up point of the 1st party member's HP bar", _
 	"8. Specify right-bottom point of the 1st party member's HP bar", _
	"9. Specify point with color of the 1st party member's full HP", _
 	"10. Specify left-up point of the 2nd party member's HP bar", _
 	"11. Specify right-bottom point of the 2nd party member's HP bar", _
 	"12. Specify left-up point of the 3rd party member's HP bar", _
 	"13. Specify right-bottom point of the 3rd party member's HP bar", _
 	"14. Specify left-up point of the 4th party member's HP bar", _
 	"15. Specify right-bottom point of the 4th party member's HP bar", _
 	"16. Specify left-up point of the 5th party member's HP bar", _
 	"17. Specify right-bottom point of the 5th party member's HP bar", _
 	"18. Specify left-up point of the 6th party member's HP bar", _
 	"19. Specify right-bottom point of the 6th party member's HP bar", _
 	"20. Specify left-up point of the 7th party member's HP bar", _
 	"21. Specify right-bottom point of the 7th party member's HP bar", _
 	"22. Specify left-up point of the 8th party member's HP bar", _
 	"23. Specify right-bottom point of the 8th party member's HP bar" _
]

global const $kParamNames[$kParamCount] = [ _
 	"kSelfHealthLeft", _
 	"kSelfHealthRight", _
 	"kSelfHealthColor", _
 	"kSelfManaLeft", _	
 	"kSelfManaRight", _	
 	"kSelfManaColor", _
	"kFirstHealthLeft", _
 	"kFirstHealthRight", _
 	"kPartyHealthColor", _
	"kSecondHealthLeft", _
 	"kSecondHealthRight", _
	"kThirdHealthLeft", _
 	"kThirdHealthRight", _
	"kFourthHealthLeft", _
 	"kFourthHealthRight", _
	"kFifthHealthLeft", _
 	"kFifthHealthRight", _
	"kSixthHealthLeft", _
 	"kSixthHealthRight", _
	"kSeventhHealthLeft", _
 	"kSeventhHealthRight", _
	"kEighthHealthLeft", _
 	"kEighthHealthRight" _
]

global const $kConfigFile = "../conf/interface_healer.au3"

#include "../source/configurator.au3"
