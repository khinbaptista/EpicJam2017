extends KinematicBody2D

signal death

export(float) var pushback = 20.0

func _ready():
	get_tree().get_root().get_node("/root/death_listener").player = self

func hit(damage, dir = Vector2()):
	var health = get_node("attributes/health")
	health.value -= damage
	
	if health.value == 0:
		emit_signal("death")
	
	move(dir * pushback)
