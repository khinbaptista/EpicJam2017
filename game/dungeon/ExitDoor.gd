extends Area2D

export(bool) var is_open = true

func _ready():
	connect("body_enter", self, "on_player_enter")

func on_player_enter(body):
	if(is_open and body.get_name() == "player"):
		get_node("/root/ScenesData").loadNextScene()
