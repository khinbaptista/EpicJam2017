extends Node

export(PackedScene) var surround_attack
export(PackedScene) var directional_attack
export(PackedScene) var ranged_attack
var damage_attr

var anim_player

onready var player = get_parent()

func _ready():
	damage_attr = get_node("../attributes/damage")
	anim_player = get_parent().get_node("AnimationPlayer")
	set_process_input(true)

func _input(event):
	
	if(anim_player.is_playing() && anim_player.get_current_animation().ends_with("attack")):
		return;
	
	if event.is_action_pressed("attack_melee_surround") and not event.is_echo():
		var attack = surround_attack.instance()
		attack.player = player
		attack.set_global_pos(player.get_global_pos())
		attack.damage = damage_attr.value
		anim_player.speed = 1
		anim_player.play("area_attack")
		add_child(attack)
	
	if event.is_action_pressed("attack_melee_directional") and not event.is_echo():
		var attack = directional_attack.instance()
		attack.player = player
		attack.set_global_pos(player.get_global_pos())
		attack.set_global_rot(player.get_global_rot())
		attack.damage = damage_attr.value
		anim_player.speed = 1.6
		anim_player.play("melee_attack")
		add_child(attack)
		
	if event.is_action_pressed("attack_ranged") and not event.is_echo():
		var attack = ranged_attack.instance()
		attack.player = player
		attack.set_global_pos(player.get_global_pos())
		attack.set_global_rot(player.get_global_rot())
		attack.damage = damage_attr.value
		anim_player.speed = 1.0
		anim_player.play("melee_attack")
		add_child(attack)
