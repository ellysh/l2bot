; Skills
global const $kAttackSkill = "{F2}"

func OnAttack()
endfunc

func OnAttackSkill()
	SendClient($kAttackSkill, 1000)
endfunc

func OnFirstKill()
endfunc

func OnAllKill()
	PickDrop(5)
endfunc

func NextTarget()
	LogWrite("NextTarget()")
	SendClient($kNextTargetKey, 800)
endfunc

func OnAttackTimeout()
	SendClient($kCancelTarget, 50)
	ChangePosition()	
endfunc

func OnBuffTimeout()
endfunc