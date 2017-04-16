extends KinematicBody2D

signal death

export(float) var pushback = 20.0

func _ready():
	get_tree().get_root().get_node("/root/death_listener").player = self

func kill():
	hit(get_node("attributes/health").value)

func hit(damage, dir = Vector2()):
	var health = get_node("attributes/health")
	health.value -= damage
	
	if health.value == 0:
		var anim = get_node("AnimationPlayer")
		anim.play("death")
		anim.connect("finished", self, "emit_signal", ["death"])
	
	move(dir * pushback)
