global const $kParamCount = 5
global const $kTipText[$kParamCount] = [ _
	"1. Укажите левую-верхнюю точку окна рулетки", _
	"2. Укажите правую-нижнюю точку окна рулетки", _	
	"3. Укажите поле ввода суммы ", _
	"4. Укажите кнопку `Красное`", _
	"5. Укажите кнопку `Черное`" _
]

global const $kParamNames[$kParamCount] = [ _
	"kRouletteWindowLeft", _
	"kRouletteWindowRight", _
	"kInputField", _
	"kRedButton", _	
	"kBlackButton" _
]

global const $kConfigFile = "../conf/interface_roulette.au3"
global const $kIsMoveControlPos = false

#include "../source/configurator.au3"
