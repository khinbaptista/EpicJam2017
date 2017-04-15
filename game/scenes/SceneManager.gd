extends Node2D

export(String) var sceneName1 = "res://scenes/scenePH.png"
export(String) var sceneName2 = "res://scenes/text.png"
export(String) var sceneName3 = "res://scenes/scenePH.png"
export(float) var sceneTime = 20

var currentScene

var sprite
var sprite2

var centerX
var centerY
var scaleX
var scaleY

var globalTimer = 0

func _ready():
	var viewportRect = get_viewport_rect()
	sprite = get_child(0)
	sprite2 = get_child(1)
	
	centerX = viewportRect.size.x / 2
	centerY = viewportRect.size.y / 2
	
	currentScene = load(sceneName1)
	
	scaleX = viewportRect.size.x / currentScene.size.x
	scaleY = viewportRect.size.y / currentScene.size.y
	
	sprite.set_texture(currentScene)
	sprite.set_scale(Vector2(scaleX, scaleY))
	sprite.set_pos(Vector2(centerX, centerY))
	
	sprite2.hide()
	fade_out(sprite2)
	sprite2.set_texture(currentScene)
	sprite2.set_scale(Vector2(scaleX, scaleY))
	sprite2.set_pos(Vector2(centerX, centerY))
	set_fixed_process(true)
	
func _fixed_process(delta):
	globalTimer += delta
	if(globalTimer % sceneTime == 0):
		nextScene()
		
func nextScene():
	pass
	
func swapScene(obj1, obj2):
	if(obj2.is_hidden()):
		obj2.show()
	fade_out(obj1)
	fade_in(obj2)
	
func fade_out(obj):
	var t = Tween.new()
	add_child(t)
	t.interpolate_property(obj, "visibility/opacity", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.start()
	
func fade_in(obj):
	var t = Tween.new()
	add_child(t)
	t.interpolate_property(obj, "visibility/opacity", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	t.start()