extends Area2D

export var damage = 1.0
export var move = false
export var speed = 200.0

func _ready():
	connect("body_enter", self, "on_body_enter")
	if move:
		set_fixed_process(true)

func _fixed_process(delta):
	if move:
		set_global_pos(get_global_pos() + Vector2(0, 1).rotated(get_global_rot()) * speed * delta)

func on_body_enter(body):
	if body.has_method("hit"):
		body.hit(damage)

func finished():
	queue_free()
