extends "res://fsm/FSM.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_user_signal("idle");
	add_user_signal("seek");
	add_user_signal("attack");
	
	add_transition("Idle", "Seeking", "seek");
	add_transition("Seeking", "Attacking", "attack");
	add_transition("Idle", "Attacking", "attack");
	add_transition("Seeking", "Idle", "idle");
	add_transition("Attacking", "Idle", "idle");
	pass
