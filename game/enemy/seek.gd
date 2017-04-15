extends "res://fsm/state.gd"

onready var character = machine.get_parent()

var target

func on_enter():
	.on_enter()
	if target == null: machine.make_transition("idle")
	set_process(true)

func _process(delta):
	var next = character.level.get_path(character.get_pos(), target.get_pos())
	character.move_to(next[0])

func body_exit(body):
	if body == target:
		machine.make_transition("idle")

func on_exit():
	set_process(false)
	.on_exit()
