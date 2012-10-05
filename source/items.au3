func PickDrop($count)
	for $i = 0 to $count step 1
		Send($gPickDropKey)
		Sleep(500)
	next
endfunc

func PotionHealing()
	if IsHealthCritical() then
		Send($gHeathPoitionKey)
		Sleep(500)
	endif
endfunc
