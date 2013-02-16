func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey, 600)
	next
endfunc

func PickDropWin($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey, 1000)
	next
endfunc

func PotionHealing()
	LogWrite("PotionHealing()")
	SendClient($kHeathPoitionKey, 500)
endfunc

func ManaPotion()
	LogWrite("ManaPotion()")
	SendClient($kManaPoitionKey, 500)
endfunc
