extends Node2D

var scenes = []

export(float) var sceneTime = 5

var currentScene
var nextScene
var currentSprite
var nextSprite

var sprite
var sprite2

var centerX
var centerY
var scaleX
var scaleY
var i = 1

var globalTimer = 0

var first = true

func _ready():
	scenes.append("res://scenes/Ending_1.png")
	scenes.append("res://scenes/Ending_2.png")
	scenes.append("res://scenes/Ending_3.png")
	scenes.append("res://scenes/Ending_4.png")
	scenes.append("res://scenes/Ending_5.png")
	scenes.append("res://scenes/Ending_6.png")
	scenes.append("res://scenes/Ending_7.png")
	scenes.append("res://scenes/Ending_8.png")
	scenes.append("res://scenes/Ending_9.png")
	scenes.append("res://scenes/Ending_10.png")
	
	var viewportRect = get_viewport_rect()
	sprite = get_child(0)
	sprite2 = get_child(1)
	
	centerX = viewportRect.size.x / 2
	centerY = viewportRect.size.y / 2
	
	currentScene = load(scenes[0])
	nextScene = load(scenes[1])
	
	currentSprite = sprite
	nextSprite = sprite2
	
	scaleX = viewportRect.size.x / currentScene.size.x
	scaleY = viewportRect.size.y / currentScene.size.y
	
	sprite.set_texture(currentScene)
	sprite.set_scale(Vector2(scaleX, scaleY))
	sprite.set_pos(Vector2(centerX, centerY))
	
	sprite2.set_texture(nextScene)
	sprite2.set_scale(Vector2(scaleX, scaleY))
	sprite2.set_pos(Vector2(centerX, centerY))
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	globalTimer += delta
	if(globalTimer > sceneTime):
		globalTimer = 0
		swapScene()
		
func loadNext():
	if(i < scenes.size() - 1):
		var aux = nextSprite
		nextSprite = currentSprite
		currentSprite = aux
		i += 1
		nextScene = load(scenes[i])
		nextSprite.set_texture(nextScene)
	else:
		get_node("/root/ScenesData").i = 0
		get_tree().change_scene("res://menus/start_menu.tscn")
	
func swapScene():
	if(first):
		first_to_second()
		first = false
	else:
		second_to_first()
		first = true
	
func first_to_second():
	get_child(2).play("first_to_second")
	
func second_to_first():
	get_child(2).play("second_to_first")