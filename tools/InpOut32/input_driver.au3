#include <InpOut.au3>

func Setup()
	return _IsInpOutDriverOpen()
endfunc

func PS2_Command($command, $value)
	if not _IsInpOutDriverOpen() then
		LogWrite("PS/2 Keyboard port driver is not opened")
		return
	endif
	
    ;keyboard wait.
	$kb_wait_cycle_counter = 100
	
	;wait to get communication.
	do
		$input = BitAND(_Inp32(0x64), 0x02)
		$kb_wait_cycle_counter -= 1
		Sleep(1)
	until $input = 0 or $kb_wait_cycle_counter = 0
	
	;if it didn't timeout.
    if $kb_wait_cycle_counter <> 0 then
		_Out32(0x64, $command) ;send command
        $kb_wait_cycle_counter = 100
			
		;wait to get communication.
		do
			$input = BitAND(_Inp32(0x64), 0x02)
			$kb_wait_cycle_counter -= 1
            Sleep(1)
		until $input = 0 or $kb_wait_cycle_counter = 0
			
        if $kb_wait_cycle_counter = 0 then
			LogWrite("failed to get communication in cycle counter timeout, who knows what will happen now")
			return false
        endif

		;send data as short
        _Out32(0x60, $value)
        Sleep(1)
		return true
    else
        LogWrite("failed to get communication in counter timeout, busy")
		return false
    endif
endfunc

func PS2_PressKey($scan_code, $release = false, $delay = 0)
	$result = false
	
	LogWrite("scan_code = " & $scan_code)

	; extra command for Up/Down/Right/Left arrow keys
	if $scan_code =	0x48 or $scan_code = 0x4B or $scan_code = 0x4D or $scan_code = 0x50 then
		$result = PS2_Command(0xD2, 0xE0);
		LogWrite("result #0 = " & $result)
	endif
	
	;0xD2 - Write keyboard output buffer
	$result = PS2_Command(0xD2, $scan_code)
	LogWrite("result #1 = " & $result)

	if $release then
		$scan_code = BitOR($scan_code, 0x80)
		$result = PS2_Command(0xD2, $scan_code)
		LogWrite("result #2 = " & $result)
	endif
	
	if $delay <> 0 then
		Sleep($delay)
	endif
	
endfunc

func ConvertKey($key)
	local $result[2]
	$result[0] = 0
	$result[1] = true
	
	switch $key
		case "{F1}"
			$result[0] = 0x3B
		case "{F2}"
			$result[0] = 0x3C
		case "{F3}"
			$result[0] = 0x3D
		case "{F4}"
			$result[0] = 0x3E
		case "{F5}"
			$result[0] = 0x3F
		case "{F6}"
			$result[0] = 0x40
		case "{F7}"
			$result[0] = 0x41
		case "{F8}"
			$result[0] = 0x42
		case "{F9}"
			$result[0] = 0x43
		case "{F10}"
			$result[0] = 0x44
		case "{F11}"
			$result[0] = 0x57
		case "{F12}"
			$result[0] = 0x58
		case "1"
			$result[0] = 0x02
		case "2"
			$result[0] = 0x03
		case "3"
			$result[0] = 0x04
		case "4"
			$result[0] = 0x05
		case "5"
			$result[0] = 0x06
		case "6"
			$result[0] = 0x07
		case "7"
			$result[0] = 0x08
		case "8"
			$result[0] = 0x09
		case "9"
			$result[0] = 0x0A
		case "0"
			$result[0] = 0x0B
		case "{DOWN down}"
			$result[0] = 0x4B
			$result[1] = false
		case "{DOWN up}"
			$result = 0x4B
		case "{UP down}"
			$result[0] = 0x48
			$result[1] = false
		case "{UP up}"
			$result[0] = 0x48
		case "{ESC}"
			$result[0] = 0x01
	endswitch
	return $result
endfunc

func _Send($key, $flag = 0)
	$scan_code = ConvertKey($key)
	
	LogWrite("_Send() - key = " & $key & " scan_code = " & $scan_code[0])
	
	PS2_PressKey($scan_code[0], $scan_code[1])
endfunc
