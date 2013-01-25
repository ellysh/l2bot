; FIXME: Make Russian and English variant of tips
global const $kParamCount = 7
global const $kTipText[$kParamCount] = [ _
	"Укажите левую-нижнюю точку окна рыбалки", _
	"Укажите правую-верхнюю точку окна рыбалки", _	
	"Укажите первую точку окна рыбалки с характерным цветом", _
	"Укажите вторую точку окна рыбалки с характерным цветом", _
	"Укажите левую-нижнюю точку на полоске HP рыбы", _
	"Укажите правую-верхнюю точку на полоске HP рыбы", _	
	"Укажите точку на полной полоске HP рыбы с характерным цветом" _
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
