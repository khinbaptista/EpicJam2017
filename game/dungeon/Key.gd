extends Node2D

func _ready():
	connect("body_enter", self, "on_player_enter")

func on_player_enter(body):
	if(body.get_name() == "player"):
		get_node("../ExitDoor").is_open = true
		queue_free()
