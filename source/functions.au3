WaitGrabCommand()

global const $kWindowHandle = WinGetHandle("")

WaitStartCommand()

LogWrite("Window handle = " & $kWindowHandle)

Sleep(3000)

global const $kErrorCoord = -1

func WaitGrabCommand()
	while not $gIsGrab
		Sleep(1)
	wend
endfunc

func WaitStartCommand()
	while not $gIsStart
		Sleep(1)
	wend
endfunc

if not WinExists($kWindowHandle) then
	LogWrite("Window not exist")
	exit
endif

func SendClient($key, $delay)
	LogWrite("SendClient() - " & $key)
	;ControlSend($kWindowHandle, "", "", $key)
	Send($key)
	Sleep($delay)
endfunc

func SendSplitText($text)
	local $key_array = StringSplit($text, "")

	for $i = 1 to $key_array[0] step 1
		SendClient($key_array[$i], 20)
	next
	Sleep(200)
endfunc

func SendTextClient($text)
	LogWrite("SendTextClient() - " & $text)

	SendClient($kEnterKey, 200)

	SendSplitText($text)
	
	SendClient($kEnterKey, 500)
endfunc

func SendTextClientWin($text)
	LogWrite("SendTextClient() - " & $text)

	SendClient($kEnterKey, 1000)
	
	SendClient($text, 1000)
	
	SendClient($kEnterKey, 1000)
endfunc


func IsPixelExistClient($window_pos, $color)
	;local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 0, 1, $kWindowHandle)
	local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 10)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func GetPixelCoordinateClient($window_pos, $color)
	local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 10)
	
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
	LogWrite("MouseClickClient() - " & $botton & $x & $y)
	MouseClick($botton, $x, $y, 1, 1)
	;ControlClick($kWindowHandle, "", "", $botton, 1, $x, $y)
endfunc

func GetBarValue($coord, $bar_pos)
	local $result = ($coord[0] - $bar_pos[2]) / ($bar_pos[0] - $bar_pos[2]) * 100
	return $result
endfunc
