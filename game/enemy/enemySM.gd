extends "res://fsm/FSM.gd"

func _ready():
	add_transition("Idle", "Seeking", "seek");
	add_transition("Seeking", "Attacking", "attack");
	#add_transition("Idle", "Attacking", "attack");
	add_transition("Seeking", "Idle", "idle");
	add_transition("Attacking", "Seeking", "seek")
	#add_transition("Attacking", "Idle", "idle");
	
	set_current_state("Idle")
