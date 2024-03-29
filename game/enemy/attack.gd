extends "res://fsm/state.gd"

export(float) var attack_cooldown
var attack_timer = 0.0

onready var character = machine.get_parent()
var target

func on_enter():
	.on_enter()
	attack_timer = attack_cooldown
	set_process(true)

func _process(delta):
	attack_timer += delta
	
	if attack_timer >= attack_cooldown:
		character.atkdelay_c = 0
		character.currAtk = character.attack(target)
		attack_timer = 0.0

func body_exit(body):
	if body == target:
		machine.get_node("Seeking").target = body
		machine.make_transition("seek")

func on_exit():
	set_process(false)
	.on_exit()