extends KinematicBody2D

signal death

func _ready():
	pass

func hit(damage):
	var health = get_node("attributes/health")
	health.value -= damage
	
	if health.value == 0:
		emit_signal("death")
		get_tree().quit()
