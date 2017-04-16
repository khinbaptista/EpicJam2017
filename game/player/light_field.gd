extends Node

var light
var health_attr

var max_health
var health

var max_scale

func _ready():
	health_attr = get_node("../attributes/health")
	light = get_node("../light")
	max_scale = light.get_scale().x
	
	health_attr.connect("changed", self, "update")
	health_attr.connect("changed_max", self, "update")
	update()

func update():
	max_health = health_attr.get_max()
	health = health_attr.value
	
	var percent = health / max_health
	light.set_scale(Vector2(percent*max_scale,percent*max_scale))
	