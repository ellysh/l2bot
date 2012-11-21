global const $gWindowHandle = WinGetHandle("[CLASS:l2UnrealWWindowsViewportWindow]")

func SendClient($key)
	;Send($key)
	ControlSend($gWindowHandle, "", "", $Key)
endfunc

func SendTextClient($text)
	$key_array = StringSplit($text, "")

	for $i = 1 to $key_array[0] step 1
		ControlSend($gWindowHandle, "", "", $key_array[$i])
		Sleep(200)
	next
endfunc

func IsPixelExistClient($window_pos, $color)
	local $coord = PixelSearch($window_pos[0], $window_pos[1], $window_pos[2], $window_pos[3], $color, 0, 1, $gWindowHandle)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func PixelPixelGetColorClient($point)
	return PixelGetColor($point[0], $point[1], $gWindowHandle)
endfunc

func MouseClickClient($botton, $x, $y)
	MouseClick($botton, $x, $y, 1, 1)
	;ControlClick("[CLASS:l2UnrealWWindowsViewportWindow]", "", "", $botton, 1, $x, $y)
endfunc