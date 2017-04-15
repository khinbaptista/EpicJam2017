extends Node

var player
var movement_attr

func _ready():
	player = get_parent()
	movement_attr = player.get_node("attributes/movement_speed")
	set_fixed_process(true)

func _fixed_process(delta):
	var movement = Vector2()
	
	if Input.is_action_pressed("move_up"):
		movement.y -= 1.0
	if Input.is_action_pressed("move_down"):
		movement.y += 1.0
	if Input.is_action_pressed("move_left"):
		movement.x -= 1.0
	if Input.is_action_pressed("move_right"):
		movement.x += 1.0
	
	movement = movement.normalized()
	player.move(movement * movement_attr.value * delta)
