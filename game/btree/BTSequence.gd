extends "BTCompositeNode.gd"

func _ready():
	._ready()

func tick(delta):
	var status = children[current_child].tick(delta)
	if status == STATUS_SUCCESS:
		current_child += 1
		if current_child >= children.count():
			return STATUS_SUCCESS
		return STATUS_RUNNING
	
	return status
