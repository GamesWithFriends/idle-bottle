extends OptionButton


func _ready():
	update_options()
	connect("item_selected", self._on_item_selected)

func update_options():
	add_item("330 ml", 0)
	if GlobalVariables.bottleSize500:
		add_item("500 ml", 1)
	if GlobalVariables.bottleSize1000:
		add_item("1000 ml", 2)
	if GlobalVariables.bottleSize1500:
		add_item("1500 ml", 3)
	if GlobalVariables.bottleSize2000:
		add_item("2000 ml", 4)

func _on_item_selected(index):
	match index:
		0:
			do_something_for_bottle(330)
		1:
			do_something_for_bottle(500)
		2:
			do_something_for_bottle(1000)
		3:
			do_something_for_bottle(1500)
		4:
			do_something_for_bottle(2000)

func do_something_for_bottle(bottle_size):
	GlobalVariables.currBottle = bottle_size
