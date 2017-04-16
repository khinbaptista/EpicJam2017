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
	scenes.append("res://scenes/Text1.png")
	scenes.append("res://scenes/Text2.png")
	scenes.append("res://scenes/Text3.png")
	scenes.append("res://scenes/Text4.png")
	scenes.append("res://scenes/Text5.png")
	scenes.append("res://scenes/Text6.png")
	scenes.append("res://scenes/Text12.png")
	scenes.append("res://scenes/Text13.png")
	
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
	set_process_input(true)
	
func _fixed_process(delta):
	globalTimer += delta
	if(globalTimer > sceneTime):
		globalTimer = 0
		swapScene()
		
func _input(event):
	if(event.is_action_pressed("ui_accept") and not event.is_echo()):
		get_child(2).stop(true)
		if(i < scenes.size() - 1):
			currentSprite.set_texture(nextScene)
			i += 1
			nextScene = load(scenes[i])
			nextSprite.set_texture(nextScene)
		else:
			get_tree().change_scene("res://scenes/CardsScene.tscn")
		
func loadNext():
	if(i < scenes.size() - 1):
		var aux = nextSprite
		nextSprite = currentSprite
		currentSprite = aux
		i += 1
		nextScene = load(scenes[i])
		nextSprite.set_texture(nextScene)
	else:
		#get_tree().get_root().get_node("/root/bgm").play("")
		get_tree().change_scene("res://scenes/CardsScene.tscn")
	
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