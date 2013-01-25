#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

; FIXME: Make Russian and English variant of tips
global const $kParamCount = 17
global const $kTipText[$kParamCount] = [ _
	"Укажите левую-нижнюю точку окна цели", _
	"Укажите правую-верхнюю точку окна цели", _	
	"Укажите первую точку окна цели с характерным цветом", _
	"Укажите вторую точку окна цели с характерным цветом", _
	"Укажите левую-нижнюю точку на полоске HP цели", _
	"Укажите правую-верхнюю точку на полоске HP цели", _	
	"Укажите точку на полной полоске HP цели с характерным цветом", _
	"Укажите левую-нижнюю точку на полоске MP цели (выделите себя или пета)", _
	"Укажите правую-верхнюю точку на полоске MP цели (выделите себя или пета)", _	
	"Укажите точку на полной полоске MP цели с характерным цветом (выделите себя или пета)", _	
	"Укажите точку на пустой полоске MP цели с характерным цветом (выделите себя или пета)", _		
 	"Укажите левую-нижнюю точку на полоске HP персонажа", _
 	"Укажите правую-верхнюю точку на полоске HP персонажа", _	
	"Укажите точку на полной полоске HP персонажа с характерным цветом", _	
	"Укажите левую-нижнюю точку на полоске MP персонажа", _
	"Укажите правую-верхнюю точку на полоске MP персонажа", _
	"Укажите точку на полной полоске MP персонажа с характерным цветом" _	
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
 	"kSelfManaColor" _	
]

global const $kConfigFile = "../conf/interface.au3"

global $gTipIndex = 0
global $gIsSelect = false
global $gCoord[2] = [0, 0]
global $gColor = 0x000000

HotKeySet("!{F3}", "_GetCursorPos")

func _GetCursorPos()
	$gCoord = MouseGetPos()
	$gColor = PixelGetColor($gCoord[0], $gCoord[1])
	$gIsSelect = true
	LogWrite("_GetCursorPos() - x = " & $gCoord[0] & " y = " & $gCoord[1] & " color = " & Hex($gColor, 6))
endfunc

func FindEdge($step)
	$check_coord = $gCoord
	
	while $gCoord[0] <> 0 and $gColor == GetPixelColorClient($check_coord)
		$check_coord[0] = $check_coord[0] + $step
	wend
	
	LogWrite("FindEdge() - color = " & Hex($gColor, 6) & " check_color = " & Hex(GetPixelColorClient($check_coord), 6))
	
	return $check_coord[0]
endfunc

func WritePoint($param, $x, $y)
	FileWrite($kConfigFile, "global const $" & $param & "[2] = [" & _
			  $x & "," & $y & "]" & chr(10))
endfunc

func WriteColor($param, $color)
	FileWrite($kConfigFile, "global const $" & $param & " = 0x" & Hex($color, 6) & chr(10))
endfunc

FileDelete($kConfigFile)

; Main Loop
while true
	ToolTip($kTipText[$gTipIndex])

	if $gIsSelect = true then
		local $param = $kParamNames[$gTipIndex]

		if StringInStr($param, "Color") then
			WriteColor($param, $gColor)
		else
			WritePoint($param, $gCoord[0], $gCoord[1])		
		endif

		$gTipIndex = $gTipIndex + 1
		$gIsSelect = false
	endif

	if $gTipIndex = $kParamCount then
		WritePoint("kMoveControlPos1", 550, 590)
		WritePoint("kMoveControlPos2", 640, 370)
		WritePoint("kMoveControlPos3", 770, 590)
		exit
	endif
	
	Sleep(1)
wend
