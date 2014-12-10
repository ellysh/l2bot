#include <SendMessage.au3>

ProcessHide(@AutoItPID)
WaitGrabCommand()

Sleep(200)

; This is needed for Windows Vista and above
#RequireAdmin
#NoTrayIcon

Opt("SendKeyDownDelay", 10)
Opt("PixelCoordMode", 2)
Opt("MouseCoordMode", 2)

global const $kMinute = 60 * 1000
global const $kErrorCoord = -1
global const $kToggleCount = 12
global $gToggleList[$kToggleCount]

func ProcessHide($PID)
	DllCall("HideProcessNT.dll","long","HideNtProcess","dword",$PID)
endfunc

func WaitGrabCommand()
	while not $gIsGrab
		Sleep(1)
	wend
endfunc

func SendClient($key, $delay)
	LogWrite("SendClient() - " & $key)
	Send($key, 0)
	Sleep($delay)
endfunc

func SendSymbolClient($key, $delay)
	LogWrite("SendSymbolClient() - " & $key)
	Send($key, 1)
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
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 1)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func IsPixelsChanged($left, $right, byref $checksum)
	LogWrite("IsPixelsChanged()")

	local $newsum = PixelChecksum($left[0], $left[1], $right[0], $right[1])

	if $newsum <> $checksum then
		LogWrite("	- changed new checksum = " & $newsum & " old checksum = " & $checksum)	
		$checksum = $newsum
		return true
	else
		LogWrite("	- same checksum = " & $newsum)
		return false
	endif
endfunc

func GetPixelCoordinateClient($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 4)
	
	if not @error then
		return $coord
	else
		local $error[2] = [$kErrorCoord, $kErrorCoord]
		return $error
	endif
endfunc

func GetPixelColorClient($point)
	return PixelGetColor($point[0], $point[1])
endfunc

func MouseClickClient($botton, $x, $y)
	LogWrite("MouseClickClient() - " & $botton & " x = " & $x & " y = " & $y)
	MouseClick($botton, $x, $y)
endfunc

func GetBarValue($coord, $bar_left, $bar_right)
	local $result = ($coord[0] - $bar_left[0]) / ($bar_right[0] - $bar_left[0]) * 100
	
	LogWrite("GetBarValue() - result = " & Round($result, 2) & "%")
	
	return $result
endfunc

func SwitchToggle($number, $key, $state)
	LogWrite("SwitchToggle() - number = " & $number & " key = " & $key & " state = " & $state)
	
	if $kToggleCount <= $number then
		return
	endif
	
	if $gToggleList[$number] == $state then
		return
	endif
	
	SendClient($key, 1000)
	$gToggleList[$number] = $state
endfunc

func IsCoordinateCorrect($coordinate)
	if $coordinate[0] <> $kErrorCoord and $coordinate[1] <> $kErrorCoord then
		return true
	else
		return false
	endif
endfunc
