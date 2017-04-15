extends "BTRepeater"

var character

func _ready():
	root = self
	character = get_parent()
	
	if get_child(0) extends "BTNode.gd":
		child = get_child(0)
	
	set_process(true)

func _process(delta):
	tick(delta)

func get_character():
	return character
