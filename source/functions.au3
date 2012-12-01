WaitGrabCommand()

global const $kWindowHandle = WinGetHandle("")

WaitStartCommand()

LogWrite("Window handle = " & $kWindowHandle)

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
	;Send($key)
	LogWrite("SendClient() - " & $key)
	ControlSend($kWindowHandle, "", "", $Key)
	Sleep($delay)
endfunc

func SendTextClient($text)
	LogWrite("SendTextClient() - " & $text)

	SendClient($kEnterKey, 200)
		
	$key_array = StringSplit($text, "")

	for $i = 1 to $key_array[0] step 1
		SendClient($key_array[$i], 5)
	next
	Sleep(200)
	
	SendClient($kEnterKey, 500)
endfunc

func IsPixelExistClient($window_pos, $color)
	local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 0, 1, $kWindowHandle)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func PixelGetColorClient($point)
	return PixelGetColor($point[0], $point[1], $kWindowHandle)
endfunc

func MouseClickClient($botton, $x, $y)
	LogWrite("MouseClickClient() - " & $botton & $x & $y)
	MouseClick($botton, $x, $y, 1, 1)
	;ControlClick("[CLASS:l2UnrealWWindowsViewportWindow]", "", "", $botton, 1, $x, $y)
endfunc
