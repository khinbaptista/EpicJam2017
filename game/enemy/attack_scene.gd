extends Area2D

export(float) var speed = 300.0
export(float) var duration = 10.0

var target
var damage

var timer
var direction = Vector2(0, 1)

func _ready():
	timer = 0.0
	
	set_global_pos(get_parent().get_parent().get_global_pos())
	
	
	if target != null:
		direction = (target.get_global_pos() - get_global_pos()).normalized()
	else:
		direction = Vector2(0, 1).rotated(get_global_rot())
	
	get_node("sfx").play("attack_sfx")
	set_global_rot(Vector2(0, 1).angle_to(direction))
	set_fixed_process(true)

func _fixed_process(delta):
	set_global_pos(get_global_pos() + direction * speed * delta)
	
	timer += delta
	if timer >= duration:
		set_fixed_process(false)
		queue_free()

func on_body_enter(body):
	if body.has_method("hit"):
		body.hit(damage, (body.get_global_pos() - get_global_pos()).normalized())
		queue_free()
