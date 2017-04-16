extends Area2D

func _ready():
	connect("body_enter", self, "on_player_enter")

func on_player_enter(body):
	if(body.get_name() == "player"):
		get_node("/root/ScenesData").loadNextScene()
