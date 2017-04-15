extends "BTNode.gd"

export var current_child = 0
var children = []

func _ready():
	._ready()
	
	var c = get_children()
	for child in c:
		if child extends "BTNode.gd":
			children.append(child)
