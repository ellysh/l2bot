global const $kParamCount = 5
global const $kTipText[$kParamCount] = [ _
	"1. Specify first point of the chat window for selecting nickname", _
	"2. Specify second point of the chat window for selecting nickname", _
	"3. Specify third point of the chat window for selecting nickname", _
	"4. Specify left-up point of the text input field", _
	"5. Specify right-bottom point of the text input field" _
]

global const $kParamNames[$kParamCount] = [ _
	"kNickname1", _
	"kNickname2", _
	"kNickname3", _
	"kTextLeft", _
	"kTextRight" _	
]

global const $kConfigFile = "../conf/interface_chat.au3"

#include "../source/configurator.au3"
