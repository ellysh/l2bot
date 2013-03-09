#include <WinAPI.au3>

#include "../source/debug.au3"
#include "../source/hooks.au3"
#include "../source/functions.au3"

; This is needed for Windows Vista and above
#requireadmin

global const $WM_MOUSEMOVE = 0x0200 ;mouse move
global const $WM_MOUSEWHEEL = 0x020A ;wheel up/down
global const $WM_LBUTTONDBLCLK = 0x0203 ;left button
global const $WM_LBUTTONDOWN = 0x0201
global const $WM_LBUTTONUP = 0x0202
global const $WM_RBUTTONDBLCLK = 0x0206 ;right button
global const $WM_RBUTTONDOWN = 0x0204
global const $WM_RBUTTONUP = 0x0205
global const $WM_MBUTTONDBLCLK = 0x0209 ;wheel clicks
global const $WM_MBUTTONDOWN = 0x0207
global const $WM_MBUTTONUP = 0x0208 

global const $MSLLHOOKSTRUCT = $tagPOINT & ";dword mouseData;dword flags;dword time;ulong_ptr dwExtraInfo"

global const $kScriptFile = "script.au3"
global $gCurrentTime = GetCurrentTime()
global $hHook, $hKey_Proc


func _KeyLogger()
	WriteSend(@HotKeyPressed)
	HotKeySet(@HotKeyPressed)
	Send(@HotKeyPressed)
	HotKeySet(@HotKeyPressed, "_KeyLogger")
endfunc

func _MouseLogger($nCode, $wParam, $lParam)
    Local $info, $ptx, $pty, $mouseData, $flags, $time, $dwExtraInfo
    Local $xevent = "Unknown", $xmouseData = ""
    
    If $nCode < 0 then 
        $ret = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hM_Hook[0], _
                "int", $nCode, "ptr", $wParam, "ptr", $lParam) ;recommended
        Return $ret[0]
    EndIf
    
    $info = DllStructCreate($MSLLHOOKSTRUCT, $lParam)
    $ptx = DllStructGetData($info, 1)
    $pty = DllStructGetData($info, 2)
    $mouseData = DllStructGetData($info, 3)
    $flags = DllStructGetData($info, 4)
    $time = DllStructGetData($info, 5)
    $dwExtraInfo = DllStructGetData($info, 6)

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
	
	$hKey_Proc = DllCallbackRegister("_MouseLogger", "int", "int;ptr;ptr")
	$hmod = _WinAPI_GetModuleHandle(0)
	$hHook = _WinAPI_SetWindowsHookEx($WH_MOUSE_LL, DllCallbackGetPtr($hKey_Proc), $hmod)
	
	OnAutoItExitRegister("_CustomExit")
endfunc

func WriteHeader()
	FileWrite($kScriptFile, "func CustomScript()" & chr(10))
endfunc

func WriteFooter()
	FileWrite($kScriptFile, chr(10) & "endfunc")
endfunc

func GetCurrentTime()
	local $msec = @HOUR * 60 * 60 * 1000 + @MIN * 60 * 1000 + @SEC * 1000 + @MSEC
	
	return $msec
endfunc

func GetDelay()
	local $delay = GetCurrentTime() - $gCurrentTime
	$gCurrentTime = GetCurrentTime()
	
	return $delay
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

	FileWrite($kScriptFile, '	SendClient("' & $key & '", 200)' & @CRLF)
endfunc

FileDelete($kScriptFile)

InitKeyHooks()

WriteHeader()

; Main Loop
while true
	Sleep(10)
wend
