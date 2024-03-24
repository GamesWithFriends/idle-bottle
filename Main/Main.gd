extends Control



var currBottle = 330

var Bottle330 = 0
var CounterBottle330 = 0
var InventoryBottle330 = 0
var TapWaterUpp = false
var TapWaterUppLvl = 1
var TapWaterIdleUppLvl = 1
var Money = GlobalVariables.money

var bottleSize500 = GlobalVariables.bottleSize500


func _ready():
	$LabelBottle330.text = str(Bottle330)
	$InventoryBottle330.text = str(InventoryBottle330)
	$Money.text = "$" + str(Money)
	$UppTapWater_lvl.text = str(TapWaterUppLvl)
	$UppTapWaterIdle_lvl.text = str(TapWaterIdleUppLvl)
	$StorePanel.visible = false


func _on_tap_watter_pressed():
	var water_amount = TapWaterUppLvl * 10
	var total_water = Bottle330 + water_amount
	if total_water >= 330:
		var bottles_filled = int(total_water / 330)
		var overflow = total_water % 330
		InventoryBottle330 += bottles_filled
		Bottle330 = overflow
		$LabelBottle330.text = "0/330"
	else:
		Bottle330 = total_water
	$LabelBottle330.text = str(Bottle330) + "/330"
	$InventoryBottle330.text = str(InventoryBottle330)


func _on_sell_pressed():
	var SoldValue = InventoryBottle330 * 1
	Money += SoldValue
	InventoryBottle330 = 0
	$InventoryBottle330.text = str(InventoryBottle330)
	$Money.text = "$" + str(Money)
	
	


func _on_timer_timeout():
	if TapWaterUpp:
		var water_amount = TapWaterIdleUppLvl * 10
		var total_water = Bottle330 + water_amount
		if total_water >= 330:
			var bottles_filled = int(total_water / 330)
			var overflow = total_water % 330
			InventoryBottle330 += bottles_filled
			Bottle330 = overflow
			$LabelBottle330.text = "0/330"
		else:
			Bottle330 = total_water
		$LabelBottle330.text = str(Bottle330) + "/330"
		$InventoryBottle330.text = str(InventoryBottle330)
	


func _on_tap_water_idle_pressed():
	if not TapWaterUpp and Money >= 10:
		TapWaterUpp = true
		Money -= 10;
		$Money.text = "$" + str(Money)
	


func _on_upp_tap_water_pressed():
	var upgrade_price = TapWaterUppLvl * 5
	if Money >= upgrade_price:
		Money -= upgrade_price
		TapWaterUppLvl += 1
		$UppTapWater_lvl.text = str(TapWaterUppLvl)
		$Money.text = "$" + str(Money)
	


func _on_upp_tap_water_idle_pressed():
	var upgrade_price = TapWaterIdleUppLvl * 5
	if TapWaterUpp and Money >= upgrade_price:
		Money -= upgrade_price
		TapWaterIdleUppLvl += 1
		$Money.text = "$" + str(Money)
		$UppTapWaterIdle_lvl.text = str(TapWaterIdleUppLvl)


func _on_upp_tap_water_x_10_pressed():
	var upgrade_price = TapWaterUppLvl * 5 * 10
	if Money >= upgrade_price:
		Money -= upgrade_price
		TapWaterUppLvl += 10
		$UppTapWater_lvl.text = str(TapWaterUppLvl)
		$Money.text = "$" + str(Money)


func _on_upp_tap_water_idle_x_10_pressed():
	var upgrade_price = TapWaterIdleUppLvl * 5 * 10
	if TapWaterUpp and Money >= upgrade_price:
		Money -= upgrade_price
		TapWaterIdleUppLvl += 10
		$Money.text = "$" + str(Money)
		$UppTapWaterIdle_lvl.text = str(TapWaterIdleUppLvl)
		

func _on_store_pressed():
	$StorePanel.visible = not $StorePanel.visible


func _on_buy_bottle_500_pressed():
	if not GlobalVariables.bottleSize500 and Money >= 1000:
		GlobalVariables.bottleSize500 = true
		$SelectBottleType.add_item("500 ml", 1)
		Money -= 1000
		$Money.text = "$" + str(Money)

func _on_buy_bottle_1000_pressed():
	if not GlobalVariables.bottleSize1000 and Money >= 1000:
		GlobalVariables.bottleSize1000 = true
		$SelectBottleType.add_item("1000 ml", 2)
		Money -= 1000
		$Money.text = "$" + str(Money)


func _on_buy_bottle_1500_pressed():
	if not GlobalVariables.bottleSize1500 and Money >= 1000:
		GlobalVariables.bottleSize1500 = true
		$SelectBottleType.add_item("1500 ml", 3)
		Money -= 1000
		$Money.text = "$" + str(Money)


func _on_buy_bottle_2000_pressed():
	if not GlobalVariables.bottleSize2000 and Money >= 1000:
		GlobalVariables.bottleSize2000 = true
		$SelectBottleType.add_item("2000 ml", 4)
		Money -= 1000
		$Money.text = "$" + str(Money)
