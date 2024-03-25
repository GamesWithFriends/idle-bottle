extends Control

#CurrentAmoutnOfWaterInBottle
var currentAmountOfWaterInBottleWithSize330 = 0
var currentAmountOfWaterInBottleWithSize500 = 0
var currentAmountOfWaterInBottleWithSize1000 = 0
var currentAmountOfWaterInBottleWithSize1500 = 0
var currentAmountOfWaterInBottleWithSize2000 = 0

#CurrentNumberOfSaleableBottle
var currentNumberOfSaleableBottleWithSize330= 0
var currentNumberOfSaleableBottleWithSize500= 0 
var currentNumberOfSaleableBottleWithSize1000 = 0
var currentNumberOfSaleableBottleWithSize1500 = 0
var currentNumberOfSaleableBottleWithSize2000 = 0

#TotalNumberOfBotle
var totalNumberOfBotleWithSize330 = 0

var tapWaterIdleUpgradeStatus= false
var tapDebitLevel = 1
var tapDebitIdleLevel = 1
var money = GlobalVariables.money

var currentBottleCapacity := 330


func _ready():
	$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize330)
	$AchievementsPanel/TotalBottle330Label.text = "Total number of 330 bottles: " + str(totalNumberOfBotleWithSize330)
	$Money.text = "$" + str(money)
	$UppTapWater_lvl.text = str(tapDebitLevel)
	$UppTapWaterIdle_lvl.text = str(tapDebitIdleLevel)
	$StorePanel.visible = false
	$AchievementsPanel.visible = false
	set_process_input(true)


#Store panel
func _on_store_pressed():
	$StorePanel.visible = not $StorePanel.visible
	

#Achievements panel
func _on_achievements_button_pressed():
	$AchievementsPanel.visible = not $AchievementsPanel.visible
	if totalNumberOfBotleWithSize330 >= 10:
		$AchievementsPanel/FirstAchievement.visible = true;
	if totalNumberOfBotleWithSize330 >= 100:
		$AchievementsPanel/SecondAchievement.visible = true;

#Sell
func _on_sell_pressed():
	var SoldValue = currentNumberOfSaleableBottleWithSize330 * 1
	money += SoldValue
	currentNumberOfSaleableBottleWithSize330 = 0
	$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize330)
	$Money.text = "$" + str(money)
	

#Hide panels
func hide_panel_on_click_outside(panel):
	if panel.visible:
		var mouse_position = get_viewport().get_mouse_position()
		var panel_global_rect = panel.get_global_rect()
		if not panel_global_rect.has_point(mouse_position):
			panel.visible = false


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		hide_panel_on_click_outside($StorePanel)
		hide_panel_on_click_outside($AchievementsPanel)


#Tap water click
func _on_tap_watter_pressed():
	match currentBottleCapacity:
		330:
			fill_bottle_330()
		500:
			fill_bottle_500()
		1000:
			fill_bottle_500()
		1500:
			fill_bottle_500()
		2000:
			fill_bottle_500()



#Select id from ButtonOption
func _on_select_bottle_type_item_selected(index):
	match index:
		0:
			currentBottleCapacity = 330
		1:
			currentBottleCapacity = 500	
		3:
			currentBottleCapacity = 1000	
		4:
			currentBottleCapacity = 1500	
		5:
			currentBottleCapacity = 2000	


	
func fill_bottle_330():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize330 = currentAmountOfWaterInBottleWithSize330 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize330 >= 330:
		var numberOfFilledBottleWithSize330OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize330 / 330)
		var overflow = currentAmountOfWaterInBottleWithSize330 % 330
		totalNumberOfBotleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
		currentAmountOfWaterInBottleWithSize330 = overflow
		currentNumberOfSaleableBottleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize330) + "/" + str(330)
	$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize330)
	$AchievementsPanel/TotalBottle330Label.text = "Total number of 330 bottles: " + str(totalNumberOfBotleWithSize330)
	
func fill_bottle_500():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize500 = currentAmountOfWaterInBottleWithSize500 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize500 >= 500:
		var numberOfFilledBottleWithSize500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize500 / 500)
		var overflow = currentAmountOfWaterInBottleWithSize500 % 500
		currentAmountOfWaterInBottleWithSize500 = overflow
		currentNumberOfSaleableBottleWithSize500 += numberOfFilledBottleWithSize500OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize500) + "/" + str(500)
	$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize500)


#Tap water idle buy
func _on_tap_water_idle_pressed():
	if not tapWaterIdleUpgradeStatus and money >= 10:
		tapWaterIdleUpgradeStatus = true
		money -= 10;
		$Money.text = "$" + str(money)
	


#Tap water idle
func _on_timer_timeout():
	match currentBottleCapacity:
		330:
			fill_bottleIdle_330()
		500:
			fill_bottleIdle_500()
		1000:
			fill_bottleIdle_500()
		1500:
			fill_bottleIdle_500()
		2000:
			fill_bottleIdle_500()

func fill_bottleIdle_330():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize330 = currentAmountOfWaterInBottleWithSize330 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize330 >= 330:
			var numberOfFilledBottleWithSize330OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize330 / 330)
			var overflow = currentAmountOfWaterInBottleWithSize330 % 330
			currentNumberOfSaleableBottleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
			currentAmountOfWaterInBottleWithSize330 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize330) + "/" + str(330)
		$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize330)

func fill_bottleIdle_500():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize500 = currentAmountOfWaterInBottleWithSize500 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize500 >= 500:
			var numberOfFilledBottleWithSize500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize500 / 500)
			var overflow = currentAmountOfWaterInBottleWithSize500 % 500
			currentNumberOfSaleableBottleWithSize500 += numberOfFilledBottleWithSize500OnCurrentCycle
			currentAmountOfWaterInBottleWithSize500 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize500) + "/" + str(500)
		$InventoryBottle330.text = str(currentNumberOfSaleableBottleWithSize500)
	

#Upp tap water
func _on_upp_tap_water_pressed():
	var upgrade_price = tapDebitLevel * 5
	if money >= upgrade_price:
		money -= upgrade_price
		tapDebitLevel += 1
		$UppTapWater_lvl.text = str(tapDebitLevel)
		$Money.text = "$" + str(money)
		
#Upp tap water x10
func _on_upp_tap_water_x_10_pressed():
	var upgrade_price = tapDebitLevel * 5 * 10
	if money >= upgrade_price:
		money -= upgrade_price
		tapDebitLevel += 10
		$UppTapWater_lvl.text = str(tapDebitLevel)
		$Money.text = "$" + str(money)

#Upp idle water
func _on_upp_tap_water_idle_pressed():
	var upgrade_price = tapDebitIdleLevel * 5
	if tapWaterIdleUpgradeStatus and money >= upgrade_price:
		money -= upgrade_price
		tapDebitIdleLevel += 1
		$Money.text = "$" + str(money)
		$UppTapWaterIdle_lvl.text = str(tapDebitIdleLevel)


#Upp idle water x10
func _on_upp_tap_water_idle_x_10_pressed():
	var upgrade_price = tapDebitIdleLevel * 5 * 10
	if tapWaterIdleUpgradeStatus and money >= upgrade_price:
		money -= upgrade_price
		tapDebitIdleLevel += 10
		$Money.text = "$" + str(money)
		$UppTapWaterIdle_lvl.text = str(tapDebitIdleLevel)


#Unlock BottleSize500
func _on_buy_bottle_500_pressed():
	if not GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize500 = true
		$SelectBottleType.add_item("500 ml", 1)
		money -= 1000
		$Money.text = "$" + str(money)


#Unlock BottleSize1000
func _on_buy_bottle_1000_pressed():
	if not GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize1000 = true
		$SelectBottleType.add_item("1000 ml", 2)
		money -= 1000
		$Money.text = "$" + str(money)


#Unlock BottleSize1500
func _on_buy_bottle_1500_pressed():
	if not GlobalVariables.bottleSize1500 and GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize1500 = true
		$SelectBottleType.add_item("1500 ml", 3)
		money -= 1000
		$Money.text = "$" + str(money)


#Unlock BottleSize2000
func _on_buy_bottle_2000_pressed():
	if not GlobalVariables.bottleSize2000 and GlobalVariables.bottleSize1500 and GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize2000 = true
		$SelectBottleType.add_item("2000 ml", 4)
		money -= 1000
		$Money.text = "$" + str(money)
