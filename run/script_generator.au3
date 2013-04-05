#include <WinAPI.au3>

#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $WM_LBUTTONDOWN = 0x0201
global const $MSLLHOOKSTRUCT = $tagPOINT & ";dword mouseData;dword flags;dword time;ulong_ptr dwExtraInfo"

global const $kScriptFile = "script.au3"
global $gLastTime = TimerInit()

func _KeyLogger()
	WriteSend(@HotKeyPressed)
	HotKeySet(@HotKeyPressed)
	Send(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, "_KeyLogger")
endfunc

func _MouseLogger($nCode, $wParam, $lParam)
    if $nCode < 0 then 
        $ret = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hM_Hook[0], _
                "int", $nCode, "ptr", $wParam, "ptr", $lParam)
        return $ret[0]
    endif
    
    $info = DllStructCreate($MSLLHOOKSTRUCT, $lParam)
    $ptx = DllStructGetData($info, 1)
    $pty = DllStructGetData($info, 2)

	if $wParam = $WM_LBUTTONDOWN then
		WriteMouseClick($ptx, $pty)
	endif
endfunc

func _CustomExit()
	WriteFooter()
	exit
endfunc

func InitKeyHooks()
	for $i = 0 to 256
		HotKeySet(Chr($i), "_KeyLogger")
	next
	
	for $i = 0 to 12
		HotKeySet("{F" & $i & "}", "_KeyLogger")
	next
	
	$mouse_func = DllCallbackRegister("_MouseLogger", "int", "int;ptr;ptr")
	$hmod = _WinAPI_GetModuleHandle(0)
	$hook = _WinAPI_SetWindowsHookEx($WH_MOUSE_LL, DllCallbackGetPtr($mouse_func), $hmod)
	
	OnAutoItExitRegister("_CustomExit")
endfunc

func WriteHeader()
	FileWrite($kScriptFile, "func CustomScript()" & chr(10))
endfunc

func WriteFooter()
	FileWrite($kScriptFile, '	Sleep(' & GetDelay() & ')' & @CRLF)
	FileWrite($kScriptFile, chr(10) & "endfunc")
endfunc

func GetDelay()
	local $delay = TimerDiff($gLastTime)
	$gLastTime = TimerInit()
	
	return ceiling($delay)
endfunc

func WriteMouseClick($x, $y)
	FileWrite($kScriptFile, '	Sleep(' & GetDelay() & ')' & @CRLF)

	LogWrite("WriteMouseClick() - x = " & $x & " y = " & $y & @CRLF);	
	FileWrite($kScriptFile, '	MouseClickClient("left", ' & $x & ', ' & $y & ')' & @CRLF)
endfunc

func WriteSend($key)
	FileWrite($kScriptFile, '	Sleep(' & GetDelay() & ')' & @CRLF)
	
	LogWrite("WriteSend() - asc = " & asc($key) & " key = " & $key & @CRLF);
	if asc($key) == 13 then
		$key = "{ENTER}"
	endif

	FileWrite($kScriptFile, '	Send("' & $key & '")' & @CRLF)
endfunc

FileDelete($kScriptFile)

InitKeyHooks()

WriteHeader()

; Main Loop
while true
	Sleep(10)
wend
