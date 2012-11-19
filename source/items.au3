func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($gPickDropKey)
		Sleep(500)
	next
endfunc

func PotionHealing()
	LogWrite("PotionHealing")
	if IsHealthCritical() then
		SendClient($gHeathPoitionKey)
		Sleep(500)
	endif
endfunc
