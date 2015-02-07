;#include debug.ahk

kTitle := "II"
kClass := "ahk_class l2UnrealWWindowsViewportWindow"
kUseClass := 0
kIsNumber := 1
kIsFunctionKey := 1
kIsLetter := 0
kIsSpecialKey := 0

#NoEnv
#Persistent
#SingleInstance, Force

SetKeyDelay, -1
SendMode Input
;LogWrite("Configuration - kTitle = " . kTitle . " Class = " . kClass . " kUseClass = " . kUseClass)

GetWindow()
{
	global kUseClass
	global kClass
	global kTitle
	
	if %kUseClass%
	{
		return %kClass%
	}
	else
	{
		return %kTitle%
	}
}

LoopSend(focus = 0)
{
	;LogWrite("LoopSend -  focus = " . focus)
	WinGet, WinList, List, % GetWindow()
	Loop %WinList%
	{
		IfEqual, Focus, 1
		{
			WinActivate, % "ahk_id " . WinList%A_Index%
		}
		;LogWrite("ControlSend -  key = " . A_ThisHotkey . " window = " . "ahk_id " . WinList%A_Index%)
		ControlSend, , % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}", % "ahk_id " WinList%A_Index%
	}
}

RequireAdmin()
{
	if not A_IsAdmin
	{
		DllCall("shell32\ShellExecuteA", uint, 0, str, "RunAs", str, A_AhkPath
				, str, """" . A_ScriptFullPath . """", str, A_WorkingDir, int, 1)
		ExitApp
	}
}

Process()
{
	;LogWrite("Process -  key = " . A_ThisHotkey)
	IfWinActive, % GetWindow()
	{
		LoopSend(0)
		Return
	}
	else
		Send % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}"
}


RequireAdmin()

!F1::
	ExitApp
	return
!F2::
	Send "!{F2}"
	return
$*F1::
$*F2::
$*F3::
$*F4::
$*F5::
$*F6::
$*F7::
$*F8::
$*F9::
$*F10::
$*F11::
$*F12::
	if %kIsFunctionKey%
	{
		Process()
	}
	else
	{
		Send % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}"
	}
	Return

$*0::
$*1::
$*2::
$*3::
$*4::
$*5::
$*6::
$*7::
$*8::
$*9::
	if %kIsNumber%
	{
		Process()
	}
	else
	{
		Send % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}"
	}
	Return
	
$*a::
$*b::
$*c::
$*d::
$*e::
$*f::
$*g::
$*h::
$*i::
$*j::
$*k::
$*l::
$*m::
$*n::
$*o::
$*p::
$*q::
$*r::
$*s::
$*t::
$*u::
$*v::
$*w::
$*x::
$*y::
$*z::
	if %kIsLetter%
	{
		Process()
	}
	else
	{
		Send % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}"
	}
	Return

$*Space::
$*Left::
$*Right::
$*Up::
$*Down::
$*Backspace::
$*=::
$*-::
$*[::
$*]::
$*\::
$*;::
$*'::
$*Enter::
$*`::
$*Tab::
$*.::
$*,::
$*/::
$*Delete::
$*Home::
$*End::
$*PgUp::
$*PgDn::
$*ESC::
	if %kIsSpecialKey%
	{
		Process()
	}
	else
	{
		Send % "{Blind}{" RegExReplace(A_ThisHotkey, "[*$~]") "}"
	}
	Return
