extends KinematicBody2D

signal death

export(float) var pushback = 20.0
export(float) var inv_dur = 0.5

var inv_timer = 0.0
var invincible = false
var camera
var body

func _ready():
	camera = get_node("Camera2D")
	body = get_node("Body")
	get_tree().get_root().get_node("/root/death_listener").player = self
	set_process(true)

func _process(delta):
	if(invincible):
		inv_timer -= delta
		if(inv_timer <= 0):
			body.set_opacity(1.0)
			invincible = false
			inv_timer = 0.0

func kill():
	hit(get_node("attributes/health").value)
	
func shake_screen(shk_str, shk_dur):
	camera.shake(shk_str, shk_dur)

func hit(damage, dir = Vector2()):
	if(invincible):
		return
	
	get_node("SamplePlayer").play("hit")
	
	var health = get_node("attributes/health")
	health.value -= damage
	invincible = true
	inv_timer = inv_dur
	body.set_opacity(0.3)
	shake_screen(-damage, 0.25)
	
	if health.value == 0:
		get_node("SamplePlayer").play("death", true)
		var anim = get_node("AnimationPlayer")
		anim.play("death")
		anim.connect("finished", self, "emit_signal", ["death"])
	
	move(dir * pushback)
