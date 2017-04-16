extends Camera2D

var shake = false
var shk_dur = 0.0
var shk_str = 0.0
var curr_time = 0.0

func shake(strength, duration):
	shk_dur = duration
	shk_str = strength
	curr_time = 0.0
	shake = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	if(shake):
		if(curr_time < shk_dur):
			curr_time += delta
			set_offset(Vector2(rand_range(-shk_str*5,shk_str*5),rand_range(-shk_str*20,shk_str*20)))
		else:
			set_offset(Vector2(0,0))
			shake = false
			curr_time = 0.0
		
	pass