extends Node

export(PackedScene) var surround_attack
var damage_attr

func _ready():
	damage_attr = get_node("../attributes/damage")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("attack_melee_surround") and not event.is_echo():
		var attack = surround_attack.instance()
		attack.damage = damage_attr.value
		add_child(attack)
