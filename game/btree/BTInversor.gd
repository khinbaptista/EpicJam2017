extends "BTDecoratorNode.gd"

func _ready():
	._ready()

func tick(delta):
	var status = child.tick(delta)
	if status == STATUS_RUNNING:
		return STATUS_RUNNING
	if status == STATUS_FAILURE:
		return STATUS_SUCCESS
	if status == STATUS_SUCCESS:
		return STATUS_FAILURE
