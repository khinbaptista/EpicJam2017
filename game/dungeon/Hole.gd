extends Area2D

func _ready():
	connect("body_enter", self, "on_body_enter")

func on_body_enter(body):
	if(body.get_name() == "player"):
		body.kill()
