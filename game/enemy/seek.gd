extends "res://fsm/state.gd"

onready var character = machine.get_parent()
onready var speed_attr = character.get_node("attributes/movement_speed")

var target
var path
var next_point

func on_enter():
	.on_enter()
	if target == null:
		machine.make_transition("idle")
	
	set_fixed_process(true)

func _fixed_process(delta):
	path = character.level.get_nav_path(character.get_pos(), target.get_pos())
	next_point = path[1]
	
	var distance = next_point - character.get_pos()
	character.move(distance.normalized() * delta * speed_attr.value)

func body_exit(body):
	if body == target:
		machine.make_transition("idle")

func on_exit():
	set_process(false)
	target = null
	path = null
	.on_exit()
