extends Area2D

export var damage = 1.0

func _ready():
	connect("body_enter", self, "on_body_enter")

func on_body_enter(body):
	if body.has_method("hit"):
		body.hit(damage)

func finished():
	queue_free()
