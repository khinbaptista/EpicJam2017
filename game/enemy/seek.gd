extends "res://fsm/state.gd"

onready var character = machine.get_parent()
onready var speed_attr = character.get_node("attributes/movement_speed")

var target
var path
var next_point

func on_enter():
	.on_enter()
	if target == null or not target in character.get_node("sight").get_overlapping_bodies():
		machine.make_transition("idle")
		return
	
	set_fixed_process(true)

func _fixed_process(delta):
	path = character.level.get_nav_path(character.get_pos(), target.get_pos())
	
	if path.size() < 2: return
	next_point = path[1]
	
	var distance = next_point - character.get_pos()
	character.move(distance.normalized() * delta * speed_attr.value)

func body_exit(body):
	if body == target:
		machine.make_transition("idle")

func attack_range_body_enter(body):
	if body == target:
		machine.get_node("Attacking").target = target
		machine.make_transition("attack")

func on_exit():
	set_fixed_process(false)
	target = null
	path = null
	.on_exit()
