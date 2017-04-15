extends Node

var name
var machine

export(int, 0, 100) var cooldown = 0
var waiting_cooldown = false
var locked = false
var cooldown_timer

var transitions = {}	# transition key -> next state
signal enter
signal exit

func _ready():
	name = get_name()
	machine = get_parent()

func on_enter():
	emit_signal("enter")

func on_exit():
	if (cooldown > 0):
		setup_cooldown()

	emit_signal("exit")

func setup_cooldown():
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.set_wait_time(cooldown)
	cooldown_timer.set_one_shot(true)
	cooldown_timer.connect("timeout", self, "cooldown_ended")
	cooldown_timer.start()
	waiting_cooldown = true

func cooldown_ended():
	waiting_cooldown = false
	cooldown_timer.queue_free()

func set_locked(value):
	locked = value

func can_enter():
	return not (waiting_cooldown or locked)

func add_transition(key, target):
	if transitions.has(key):
		printerr("Couldn't add transition because key", key, "already exists")
		return false
	
	transitions[key] = target
	return true

func find_transition(key):
	if transitions.has(key):
		return transitions[key]
	else:
		return self
