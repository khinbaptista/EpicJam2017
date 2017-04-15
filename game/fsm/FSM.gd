extends Node

var current_state
var states = {} setget ,get_states
var StateClass = preload("state.gd")

signal state_locked(state)
signal state_changed(state_name)

func _ready():
	var children = get_children()
	for child in children:
		if child extends StateClass:
			add_state(child.get_name(), child)

func add_state(name, state):
	if states.has(name):
		printerr("There is already a state named '", name, "' in this FSM")
		return
	
	states[name] = state

func add_transition(origin, destination, key):
	if states.has_all([origin, destination]):
		return states[origin].add_transition(key, states[destination])

	printerr("Couldn't add transition from '", origin, "' to '",\
		destination, "' because at least one of them is not in the FSM")
	return false

func get_states():
	return states;

func set_current_state(name):
	if states.has(name):
		if current_state != null:
			current_state.on_exit()

		current_state = states[name]
		current_state.on_enter()
		emit_signal("state_changed", name)
	else:
		printerr("Couldn't set state '", name, "' because it is not in the FSM")

func make_transition(key):
	var new_state = current_state.find_transition(key)

	if new_state.name == current_state.name:
		return false
	
	if not new_state.can_enter():
		emit_signal("state_locked", new_state)
		return false

	set_current_state(new_state.name)
	return true
