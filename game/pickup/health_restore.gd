extends Area2D

var PlayerClass = preload("res://player/player.gd")

func on_body_enter(body):
	if body extends PlayerClass:
		body.get_node("attributes/health").value += 1
		queue_free()
