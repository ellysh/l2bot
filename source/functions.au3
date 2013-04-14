#include <SendMessage.au3>

WaitGrabCommand()

global const $kCurrentWin = WinGetHandle("")
global const $kWindows = WinList( WinGetTitle($kCurrentWin))

Sleep(200)

Opt("SendKeyDownDelay", 10)

global const $kErrorCoord = -1
global const $kToggleCount = 12
global $gToggleList[$kToggleCount]

func WaitGrabCommand()
	while not $gIsGrab
		Sleep(1)
	wend
endfunc

func SendMultiClient($key, $flag)
	for $i = 1 to $kWindows[0][0] step 1
		_SendMessage($kWindows[$i][1], 0x6, 1)	
		Sleep(50)
		LogWrite("ControlSend() - win = " & $kWindows[$i][1])
		ControlSend("", "", $kWindows[$i][1], $key, $flag)
	next
endfunc

func SendClient($key, $delay)
	LogWrite("SendClient() - " & $key)
	
	if $kIsMultiWindow then
		SendMultiClient($key, 0)
	else
		Send($key, 0)
	endif
	
	Sleep($delay)
endfunc

func SendSymbolClient($key, $delay)
	LogWrite("SendSymbolClient() - " & $key)
	
	if $kIsMultiWindow then	
		SendMultiClient($key, 1)
	else
		Send($key, 1)
	endif
	
	Sleep($delay)	
endfunc

func SendSplitText($text)
	local $key_array = StringSplit($text, "")

	for $i = 1 to $key_array[0] step 1
		if $key_array[$i] == "!" or $key_array[$i] == "/" then
			Send($key_array[$i], 1)
		else
			Send($key_array[$i])
		endif
		Sleep(20)
	next
	Sleep(200)
endfunc

func SendTextClient($text)
	LogWrite("SendTextClient() - " & $text)

	Send($kEnterKey)
	Sleep(200)

	SendSplitText($text)
	
	Send($kEnterKey)
	Sleep(500)
endfunc

func IsPixelExistClient($window_left, $window_right, $color)
	;local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 0, 1, $kWindowHandle)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 1)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func GetPixelCoordinateClient($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 1)
	
	if not @error then
		return $coord
	else
		local $error[2] = [$kErrorCoord, $kErrorCoord]
		return $error
	endif
endfunc

func GetPixelColorClient($point)
	;return PixelGetColor($point[0], $point[1], $kWindowHandle)
	return PixelGetColor($point[0], $point[1])
endfunc

func MouseClickClient($botton, $x, $y)
	LogWrite("MouseClickClient() - " & $botton & " x = " & $x & " y = " & $y)
	MouseClick($botton, $x, $y, 1, 1)
	;ControlClick($kWindowHandle, "", "", $botton, 1, $x, $y)
endfunc

func GetBarValue($coord, $bar_left, $bar_right)
	local $result = ($coord[0] - $bar_left[0]) / ($bar_right[0] - $bar_left[0]) * 100
	
	LogWrite("GetBarValue() - result = " & Round($result, 2) & "%")
	
	return $result
endfunc

func SwitchToggle($number, $key, $state)
	LogWrite("SwitchToggle() - number = " & $number & " key = " & $key & " state = " & $state)
	
	if $kToggleCount < $number then
		return
	endif
	
	if $gToggleList[$number] == $state then
		return
	endif
	
	SendClient($key, 1000)
	$gToggleList[$number] = $state
endfunc
