global const $kParamCount = 7
global const $kTipText[$kParamCount] = [ _
	"1. Укажите левую-верхнюю точку окна рыбалки", _
	"2. Укажите правую-нижнюю точку окна рыбалки", _	
	"3. Укажите первую точку окна рыбалки с характерным цветом", _
	"4. Укажите вторую точку окна рыбалки с характерным цветом", _
	"5. Укажите левую-верхнюю точку на полоске HP рыбы", _
	"6. Укажите правую-нижнюю точку на полоске HP рыбы", _	
	"7. Укажите точку на полной полоске HP рыбы с характерным цветом" _
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

#include "../source/configurator.au3"
