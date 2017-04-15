extends Node

export(PackedScene) var surround_attack
export(PackedScene) var directional_attack
export(PackedScene) var ranged_attack
var damage_attr

onready var player = get_parent()

func _ready():
	damage_attr = get_node("../attributes/damage")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("attack_melee_surround") and not event.is_echo():
		var attack = surround_attack.instance()
		attack.set_global_pos(player.get_global_pos())
		attack.damage = damage_attr.value
		var anim_player = get_parent().get_node("AnimationPlayer")
		anim_player.play("area_attack")
		add_child(attack)
	
	if event.is_action_pressed("attack_melee_directional") and not event.is_echo():
		var attack = directional_attack.instance()
		attack.set_global_pos(player.get_global_pos())
		attack.set_global_rot(player.get_global_rot())
		attack.damage = damage_attr.value
		add_child(attack)
		
	if event.is_action_pressed("attack_ranged") and not event.is_echo():
		var attack = ranged_attack.instance()
		attack.set_global_pos(player.get_global_pos())
		attack.set_global_rot(player.get_global_rot())
		attack.damage = damage_attr.value
		add_child(attack)
