extends OptionButton


func _ready():
	update_options()
	connect("item_selected", self._on_item_selected)

func update_options():
	add_item("330 ml", 0)

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
