extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("body_enter", self, "on_player_enter")

func on_player_enter(body):
	if(body.get_name() == "player"):
		hide()