func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey, 600)
	next
endfunc

func PotionHealing()
	LogWrite("PotionHealing()")
	if IsHealthCritical() then
		LogWrite("	- use health")
		SendClient($kHeathPoitionKey, 500)
	endif
endfunc
