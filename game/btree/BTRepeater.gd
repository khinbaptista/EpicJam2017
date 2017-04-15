extends "BTDecoratorNode"

export(int) var count = -1

func _ready():
	._ready()

func tick(delta):
	var status = child.tick(delta)
	
	if count <= -1:
		return STATUS_RUNNING
	
	count -= 1
	if count > 0:
		return STATUS_RUNNING
	
	return STATUS_SUCCESS
		