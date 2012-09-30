Sleep (3000)
HotKeySet ( "{ESC}" ,"_Exit")
;Global $k

While 1
   Attack()
   Walk()
   Turn()
   Sleep(270)
WEnd

Func _Exit()
    Exit
EndFunc

Func Attack()
		Send ("{F3}") ;Следующая цель
		Sleep(1000)
		Send ("{F1}") ;Атака
		Sleep(4000)
		Send ("{F4}") ;Собрать дроп
		Sleep(4000)
EndFunc

Func Walk()
	Send("{W down}")
	Sleep(5000)
	Send("{W up}")
EndFunc

Func Turn()
	Send("{D down}")
	Sleep(1000)
	Send("{D up}")
EndFunc