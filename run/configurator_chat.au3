global const $kParamCount = 6
global const $kTipText[$kParamCount] = [ _
	"1. Укажите первую точку окна чата для выделения ника", _
	"2. Укажите вторую точку окна чата для выделения ника", _
	"3. Укажите третью точку окна чата для выделения ника", _
	"4. Укажите левую-верхнюю точку в поле ввода текста", _
	"5. Укажите правую-нижнюю точку в поле ввода текста", _
	"6. Укажите точку с цветом текста в поле ввода текста" _
]

global const $kParamNames[$kParamCount] = [ _
	"kNickname1", _
	"kNickname2", _
	"kNickname3", _
	"kTextLeft", _
	"kTextRight", _
	"kTextColor" _
]

global const $kConfigFile = "../conf/interface_chat.au3"

#include "../source/configurator.au3"
