func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey)
		Sleep(500)
	next
endfunc

func PotionHealing()
	LogWrite("PotionHealing()")
	if IsHealthCritical() then
		LogWrite("	- use health")
		SendClient($kHeathPoitionKey)
		Sleep(500)
	endif
endfunc
