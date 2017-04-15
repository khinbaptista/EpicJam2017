extends "BTDecoratorNode.gd"

func _ready():
	._ready()

func tick(delta):
	if child.tick(delta) == STATUS_RUNNING:
		return STATUS_RUNNING
	
	return STATUS_SUCCEED
