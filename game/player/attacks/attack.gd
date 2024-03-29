extends Area2D

export var damage = 1.0
export var move = false
export var speed = 200.0

var player
var direction = Vector2(0, 1)

func _ready():
	connect("body_enter", self, "on_body_enter")
	
	get_node("sfx").play("attack_sfx")
	
	if move:
		direction = Vector2(0, 1).rotated(get_global_rot())
		set_fixed_process(true)

func _fixed_process(delta):
	if move:
		set_global_pos(get_global_pos() + direction * speed * delta)

func on_body_enter(body):
	if body.has_method("hit"):
		body.hit(damage,player)
	if body.has_method("knockback"):
		body.knockback((body.get_pos() - player.get_pos()).normalized(), 1000.0)

func finished():
	queue_free()
