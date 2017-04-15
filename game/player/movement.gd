extends Node

var player
var movement_attr

func _ready():
	player = get_parent()
	movement_attr = player.get_node("attributes/movement_speed")
