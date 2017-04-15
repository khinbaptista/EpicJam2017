extends Node

export(float, 0.0, 5000.0, 0.5) var distance = 100.0
export(float, 0.1, 2.0, 0.1) var duration = 0.5

var player
var timer

var direction
var speed

func _ready():
	player = get_parent()
	speed = distance / duration
	
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("dash") and not event.is_echo():
		dash_begin(Vector2(0, 1).rotated(player.get_rot()))

func dash_begin(dir):
	direction = dir.normalized()
	timer = 0.0
	set_fixed_process(true)

func _fixed_process(delta):
	timer += delta
	if timer >= duration:
		dash_end()
		return
	
	player.move(direction * speed * delta)

func dash_end():
	set_fixed_process(false)
