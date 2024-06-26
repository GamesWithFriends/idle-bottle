extends Control


var costPerLevel = 5

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

var amountOfUpgradeOnClick = 1
var amountOfUpgradeOnIdleClick = 1

var currentBottleCapacity = 330

func _ready():
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize330.text = str(currentNumberOfSaleableBottleWithSize330)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize500.text = str(currentNumberOfSaleableBottleWithSize500)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1000.text = str(currentNumberOfSaleableBottleWithSize1000)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1500.text = str(currentNumberOfSaleableBottleWithSize1500)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize2000.text = str(currentNumberOfSaleableBottleWithSize2000)
	$AchievementsPanel/TotalBottle330Label.text = "Total number of 330 bottles: " + str(totalNumberOfBotleWithSize330)
	$Money.text =str(money)
	$LevelAmountTapWater.text = str(tapDebitLevel)
	$LevelAmountIdleTapWater.text = str(tapDebitIdleLevel)
	$LevelTapWater.text = "Level:"
	$LevelIdleTapWater.text = "Level:"
	$StorePanel.visible = false
	$AchievementsPanel.visible = false
	$InventoryPanel.visible = false
	set_process_input(true)
	
	$FlowingWaterSprite.visible = false


func _process(delta):
	if 	tapWaterIdleUpgradeStatus:
		$FillBottleSprite/FillBottleAnimation.play("FillingBottle")
		$FlowingWaterSprite/FlowingWaterAnimation.play("FlowingWater")
	if($SelectUppgradeOptions.selected == 5):
		amountOfUpgradeOnClick = calculateMaxUpgrades(tapDebitLevel)
		amountOfUpgradeOnIdleClick = calculateMaxUpgrades(tapDebitIdleLevel)
		$UppgradeTapWater.text = "Level Up x" + str(amountOfUpgradeOnClick)
		$UppgradeIdleTapWater.text = "Level Up x" + str(amountOfUpgradeOnIdleClick)
	
#Store panel
func _on_store_pressed():
	$StorePanel.visible = not $StorePanel.visible
	

#Achievements panel
func _on_achievements_button_pressed():
	$ToiletPaperSprite/ToiletPaperAnimation.play("OpenAchivementPanel")
	await  $ToiletPaperSprite/ToiletPaperAnimation.animation_finished
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
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize330.text = str(currentNumberOfSaleableBottleWithSize330)
	$Money.text =str(money)

#InventoryPanel
func _on_inventory_button_pressed():
	$InventoryOpenSprite/InventoryOpenAnimation.play("InventoryOpen")
	await $InventoryOpenSprite/InventoryOpenAnimation.animation_finished
	$InventoryPanel.visible = not $InventoryPanel.visible
func _on_close_inventory_button_pressed():
	$InventoryPanel.visible = not $InventoryPanel.visible
	$InventoryOpenSprite/InventoryOpenAnimation.play_backwards("InventoryOpen")

	

#Hide panels
func hide_panel_on_click_outside(panel):
	if panel.visible:
		var mouse_position = get_viewport().get_mouse_position()
		var panel_global_rect = panel.get_global_rect()
		if not panel_global_rect.has_point(mouse_position) && not $AchievementsButton.get_global_rect().has_point(mouse_position) && not $Store.get_global_rect().has_point(mouse_position):
			panel.visible = false
			$InventoryOpenSprite/InventoryOpenAnimation.play_backwards("InventoryOpen")
			$ToiletPaperSprite/ToiletPaperAnimation.play_backwards("OpenAchivementPanel")
		elif $AchievementsButton.get_global_rect().has_point(mouse_position) && $StorePanel.visible:
			$StorePanel.visible = false
		elif $Store.get_global_rect().has_point(mouse_position) && $AchievementsPanel.visible:
			$AchievementsPanel.visible = false



func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		hide_panel_on_click_outside($StorePanel)
		hide_panel_on_click_outside($AchievementsPanel)
		hide_panel_on_click_outside($InventoryPanel)


#Select id from ButtonOption
func _on_select_bottle_type_item_selected(index):
	match index:
		0:
			currentBottleCapacity = 330
		1:
			currentBottleCapacity = 500	
		2:
			currentBottleCapacity = 1000	
		3:
			currentBottleCapacity = 1500	
		4:
			currentBottleCapacity = 2000	

#Tap water click
func _on_tap_watter_pressed():
	match currentBottleCapacity:
		330:
			fill_bottle_330()
		500:
			fill_bottle_500()
		1000:
			fill_bottle_1000()
		1500:
			fill_bottle_1500()
		2000:
			fill_bottle_2000()



#Fill on click for 330
func fill_bottle_330():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize330 = currentAmountOfWaterInBottleWithSize330 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize330 >= 330:
		@warning_ignore("integer_division")
		var numberOfFilledBottleWithSize330OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize330 / 330)
		var overflow = currentAmountOfWaterInBottleWithSize330 % 330
		totalNumberOfBotleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
		currentAmountOfWaterInBottleWithSize330 = overflow
		currentNumberOfSaleableBottleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize330) + "/" + str(330)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize330.text = str(currentNumberOfSaleableBottleWithSize330)
	$AchievementsPanel/TotalBottle330Label.text = "Total number of 330 bottles: " + str(totalNumberOfBotleWithSize330)


#Fill on click for 500
func fill_bottle_500():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize500 = currentAmountOfWaterInBottleWithSize500 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize500 >= 500:
		@warning_ignore("integer_division")
		var numberOfFilledBottleWithSize500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize500 / 500)
		var overflow = currentAmountOfWaterInBottleWithSize500 % 500
		currentAmountOfWaterInBottleWithSize500 = overflow
		currentNumberOfSaleableBottleWithSize500 += numberOfFilledBottleWithSize500OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize500) + "/" + str(500)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize500.text = str(currentNumberOfSaleableBottleWithSize500)
	

#Fill on click for 1000
func fill_bottle_1000():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize1000 = currentAmountOfWaterInBottleWithSize1000 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize1000 >= 1000:
		@warning_ignore("integer_division")
		var numberOfFilledBottleWithSize1000OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize1000 / 1000)
		var overflow = currentAmountOfWaterInBottleWithSize1000 % 1000
		currentAmountOfWaterInBottleWithSize1000 = overflow
		currentNumberOfSaleableBottleWithSize1000 += numberOfFilledBottleWithSize1000OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize1000) + "/" + str(1000)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1000.text = str(currentNumberOfSaleableBottleWithSize1000)
	

#Fill on click for 1500
func fill_bottle_1500():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize1500 = currentAmountOfWaterInBottleWithSize1500 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize1500 >= 1500:
		@warning_ignore("integer_division")
		var numberOfFilledBottleWithSize1500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize1500 / 1500)
		var overflow = currentAmountOfWaterInBottleWithSize1500 % 1500
		currentAmountOfWaterInBottleWithSize1500 = overflow
		currentNumberOfSaleableBottleWithSize1500 += numberOfFilledBottleWithSize1500OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize1500) + "/" + str(1500)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1500.text = str(currentNumberOfSaleableBottleWithSize1500)


#Fill on click for 2000
func fill_bottle_2000():
	var currentWaterOnClick = tapDebitLevel * 10
	currentAmountOfWaterInBottleWithSize2000 = currentAmountOfWaterInBottleWithSize2000 + currentWaterOnClick
	if currentAmountOfWaterInBottleWithSize2000 >= 2000:
		@warning_ignore("integer_division")
		var numberOfFilledBottleWithSize2000OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize2000 / 2000)
		var overflow = currentAmountOfWaterInBottleWithSize2000 % 2000
		currentAmountOfWaterInBottleWithSize2000 = overflow
		currentNumberOfSaleableBottleWithSize2000 += numberOfFilledBottleWithSize2000OnCurrentCycle
	$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize2000) + "/" + str(2000)
	$InventoryPanel/CurrentNumberOfSaleableBottleWithSize2000.text = str(currentNumberOfSaleableBottleWithSize2000)


#Tap water idle buy
func _on_tap_water_idle_pressed():
	$UnlockIdleSprite/UnlockIdleAnimation.play("UnlockIdle")
	await $UnlockIdleSprite/UnlockIdleAnimation.animation_finished
	$StartWaterSprite/StartWaterAanimation.play("StartWaterAnimation")
	await $StartWaterSprite/StartWaterAanimation.animation_finished
	$StartWaterSprite.visible = false
	$FlowingWaterSprite.visible = true
	if not tapWaterIdleUpgradeStatus and money >= 10:
		$TapWaterIdle.visible = false
		tapWaterIdleUpgradeStatus = true
		money -= 10
		$Money.text =str(money)


#Tap water idle
func _on_timer_timeout():
	match currentBottleCapacity:
		330:
			fill_bottleIdle_330()
		500:
			fill_bottleIdle_500()
		1000:
			fill_bottleIdle_1000()
		1500:
			fill_bottleIdle_1500()
		2000:
			fill_bottleIdle_2000()


#Fill idle for 330
func fill_bottleIdle_330():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize330 = currentAmountOfWaterInBottleWithSize330 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize330 >= 330:
			@warning_ignore("integer_division")
			var numberOfFilledBottleWithSize330OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize330 / 330)
			var overflow = currentAmountOfWaterInBottleWithSize330 % 330
			currentNumberOfSaleableBottleWithSize330 += numberOfFilledBottleWithSize330OnCurrentCycle
			currentAmountOfWaterInBottleWithSize330 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize330) + "/" + str(330)
		$InventoryPanel/CurrentNumberOfSaleableBottleWithSize330.text = str(currentNumberOfSaleableBottleWithSize330)


#Fill idle for 500
func fill_bottleIdle_500():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize500 = currentAmountOfWaterInBottleWithSize500 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize500 >= 500:
			@warning_ignore("integer_division")
			var numberOfFilledBottleWithSize500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize500 / 500)
			var overflow = currentAmountOfWaterInBottleWithSize500 % 500
			currentNumberOfSaleableBottleWithSize500 += numberOfFilledBottleWithSize500OnCurrentCycle
			currentAmountOfWaterInBottleWithSize500 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize500) + "/" + str(500)
		$InventoryPanel/CurrentNumberOfSaleableBottleWithSize500.text = str(currentNumberOfSaleableBottleWithSize500)
		
	
#Fill idle for 1000
func fill_bottleIdle_1000():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize1000 = currentAmountOfWaterInBottleWithSize1000 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize1000 >= 1000:
			@warning_ignore("integer_division")
			var numberOfFilledBottleWithSize1000OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize1000 / 1000)
			var overflow = currentAmountOfWaterInBottleWithSize1000 % 1000
			currentNumberOfSaleableBottleWithSize1000 += numberOfFilledBottleWithSize1000OnCurrentCycle
			currentAmountOfWaterInBottleWithSize1000 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize1000) + "/" + str(1000)
		$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1000.text = str(currentNumberOfSaleableBottleWithSize1000)
		
	

#Fill idle for 1500
func fill_bottleIdle_1500():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize1500 = currentAmountOfWaterInBottleWithSize1500 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize1500 >= 1500:
			@warning_ignore("integer_division")
			var numberOfFilledBottleWithSize1500OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize1500 / 1500)
			var overflow = currentAmountOfWaterInBottleWithSize1500 % 1500
			currentNumberOfSaleableBottleWithSize1500 += numberOfFilledBottleWithSize1500OnCurrentCycle
			currentAmountOfWaterInBottleWithSize1500 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize1500) + "/" + str(1500)
		$InventoryPanel/CurrentNumberOfSaleableBottleWithSize1500.text = str(currentNumberOfSaleableBottleWithSize1500)
		
	
#Fill idle for 2000
func fill_bottleIdle_2000():
	if tapWaterIdleUpgradeStatus:
		var currentWaterOnIdle = tapDebitIdleLevel * 10
		currentAmountOfWaterInBottleWithSize2000 = currentAmountOfWaterInBottleWithSize2000 + currentWaterOnIdle
		if currentAmountOfWaterInBottleWithSize2000 >= 2000:
			@warning_ignore("integer_division")
			var numberOfFilledBottleWithSize2000OnCurrentCycle = int(currentAmountOfWaterInBottleWithSize2000 / 2000)
			var overflow = currentAmountOfWaterInBottleWithSize2000 % 2000
			currentNumberOfSaleableBottleWithSize2000 += numberOfFilledBottleWithSize2000OnCurrentCycle
			currentAmountOfWaterInBottleWithSize2000 = overflow
		$CurrentWaterInBottle.text = str(currentAmountOfWaterInBottleWithSize2000) + "/" + str(2000)
		$InventoryPanel/CurrentNumberOfSaleableBottleWithSize2000.text = str(currentNumberOfSaleableBottleWithSize2000)
		
	


#Unlock BottleSize500
func _on_buy_bottle_500_pressed():
	if not GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize500 = true
		$SelectBottleType.add_item("500 ml", 1)
		money -= 1000
		$Money.text =str(money)


#Unlock BottleSize1000
func _on_buy_bottle_1000_pressed():
	if not GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize1000 = true
		$SelectBottleType.add_item("1000 ml", 2)
		money -= 1000
		$Money.text =str(money)


#Unlock BottleSize1500
func _on_buy_bottle_1500_pressed():
	if not GlobalVariables.bottleSize1500 and GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize1500 = true
		$SelectBottleType.add_item("1500 ml", 3)
		money -= 1000
		$Money.text =str(money)


#Unlock BottleSize2000
func _on_buy_bottle_2000_pressed():
	if not GlobalVariables.bottleSize2000 and GlobalVariables.bottleSize1500 and GlobalVariables.bottleSize1000 and GlobalVariables.bottleSize500 and money >= 1000:
		GlobalVariables.bottleSize2000 = true
		$SelectBottleType.add_item("2000 ml", 4)
		money -= 1000
		$Money.text =str(money)


#Maxim of upgrade possible
func calculateMaxUpgrades(actualTapDebitLevel):
	#Suma totala a costurilor pentru upgradeuri
	var sumOfCosts = actualTapDebitLevel * costPerLevel
	#Numarul de upgrade-uri disponibile in functie de bani
	var maxUpgrades = 0
	#Verific daca suma costurilor este <= decat banii totali
	while sumOfCosts <= money:
		maxUpgrades = maxUpgrades+1;
		sumOfCosts = sumOfCosts + (actualTapDebitLevel+maxUpgrades) * costPerLevel
	return maxUpgrades;
	
#Select Uppgrade amount for click water
func _on_select_uppgrade_options_item_selected(index):
	match index:
		0:
			amountOfUpgradeOnClick = 1
			amountOfUpgradeOnIdleClick = 1
			$UppgradeTapWater.text = "Level Up x1"
			$UppgradeIdleTapWater.text = "Level Up x1"
		1:
			amountOfUpgradeOnClick = 10	
			amountOfUpgradeOnIdleClick = 10
			$UppgradeTapWater.text = "Level Up x10"
			$UppgradeIdleTapWater.text = "Level Up x10"
		2:
			amountOfUpgradeOnClick = 25	
			amountOfUpgradeOnIdleClick = 25
			$UppgradeTapWater.text = "Level Up x25"
			$UppgradeIdleTapWater.text = "Level Up x25"
		3:
			amountOfUpgradeOnClick = 50	
			amountOfUpgradeOnIdleClick = 50
			$UppgradeTapWater.text = "Level Up x50"
			$UppgradeIdleTapWater.text = "Level Up x50"
		4:
			amountOfUpgradeOnClick = 100	
			amountOfUpgradeOnIdleClick = 100
			$UppgradeTapWater.text = "Level Up x100"
			$UppgradeIdleTapWater.text = "Level Up x100"

#Uppgrade tap water
func _on_upp_tap_water_pressed():
	upgradeTapWaterByLevel(amountOfUpgradeOnClick)


#Uppgrade tap water by X levels
func upgradeTapWaterByLevel(numberOfLevels):
	var amountOfLevelOnClick = numberOfLevels
	var upgrade_price = 0
	for i in range(tapDebitLevel, tapDebitLevel + amountOfLevelOnClick):
		# where costPerLevel represent the price of each level and i is the actual level of the debit
		upgrade_price += i * costPerLevel
	if money >= upgrade_price:
		money -= upgrade_price
		tapDebitLevel += amountOfLevelOnClick
		$LevelAmountTapWater.text = str(tapDebitLevel)
		$Money.text =str(money)
		

#Uppgrade idle tap water
func _on_upp_tap_water_idle_pressed():
	upgradeIdleTapWaterByLevel(amountOfUpgradeOnIdleClick)
	

#Uppgrade idle tap water by X levels
func upgradeIdleTapWaterByLevel(numberOfLevels):
	var amountOfLevelOnClick = numberOfLevels
	var upgrade_price = 0
	for i in range(tapDebitIdleLevel, tapDebitIdleLevel + amountOfLevelOnClick):
		upgrade_price += i * costPerLevel
	if tapWaterIdleUpgradeStatus and money >= upgrade_price:
		money -= upgrade_price
		tapDebitIdleLevel += amountOfLevelOnClick
		$Money.text =str(money)
		$LevelAmountIdleTapWater.text = str(tapDebitIdleLevel)



