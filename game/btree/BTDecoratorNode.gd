extends "BTNode.gd"

var child

func _ready():
	._ready()
	
	if get_child(0) extends "BTNode.gd":
		child = get_child(0)
