extends "BTDecoratorNode"

var once = false

func _ready():
	._ready()

func tick(delta):
	var status = child.tick(delta)
	
	if status != STATUS_FAILURE:
		once = true
		return STATUS_RUNNING
	
	if once:
		return STATUS_SUCCESS
	
	return STATUS_FAILURE