extends Node2D

export(String) var sceneName = "res://scenes/scenePH.png"
var currentScene

var sprite

var centerX
var centerY
var scaleX
var scaleY

var globalTimer = 0

func _ready():
	var viewportRect = get_viewport_rect()
	sprite = get_child(0)
	
	centerX = viewportRect.size.x / 2
	centerY = viewportRect.size.y / 2
	currentScene = load(sceneName)
	scaleX = viewportRect.size.x / currentScene.size.x
	scaleY = viewportRect.size.y / currentScene.size.y
	sprite.set_texture(currentScene)
	sprite.set_scale(Vector2(scaleX, scaleY))
	sprite.set_pos(Vector2(centerX, centerY))
	fade()
	set_fixed_process(true)
	
func _fixed_process(delta):
	globalTimer += delta
	
func fade():
	var t = Tween.new()
	add_child(t)
	t.interpolate_property(sprite, "visibility/opacity", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.start()