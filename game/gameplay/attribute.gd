extends Node

export var value	= 0.0		setget set_value
export var max_value	= 5000.0	setget set_max_base
export var multiplier	= 1.0		setget set_multiplier
export var addition	= 0.0		setget set_addition

signal changed		# Emitted when the current value is changed
signal changed_max	# Emitted when the max value is changed

func _ready():
	clamp_value()
	print(get_name(), "\t", value, " / ", get_max())

func clamp_value(signalize = false):
	var maxval = get_max()
	var changed = false
	
	if value > maxval:
		value = maxval
		changed = true
	elif value < 0:
		value = 0
		changed = true
	
	if signalize and changed:
		emit_signal("changed")

func get_max():
	return max_value * multiplier + addition

func set_value(val):
	value = val
	clamp_value()
	
	emit_signal("changed")

func add_value(val):
	set_value(value + val)

func set_max_base(val):
	max_value = val
	emit_signal("changed_max")

func set_addition(bonus):
	addition = bonus
	emit_signal("changed_max")

func set_multiplier(factor):
	multiplier = factor
	emit_signal("changed_max")

func clear():
	addition = 0.0
	multiplier = 1.0
	emit_signal("changed_max")
