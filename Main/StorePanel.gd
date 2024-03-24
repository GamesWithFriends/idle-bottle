extends Panel

var Money = GlobalVariables.money

func _on_buy_bottle_500_pressed():
	if not GlobalVariables.bottleSize500 and Money >= 1000:
		GlobalVariables.bottleSize500 = true
		Money -= 1000
