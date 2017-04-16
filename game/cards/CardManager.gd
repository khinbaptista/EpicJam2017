extends Node

signal timer_end

enum TYPE{
	combat = 1,
	greedy = 2,
	maze = 3,
	puzzle = 4,
	trap = 5
}

var totalCards = 3
var totalTypes = 5
var card
var time = 1

var cardBack
var cardCombat
var cardGreedy
var cardMaze
var cardPuzzle
var cardTrap

var typesSorted = []

var totalFlipped = 0

var data 

func _ready():
	card = preload("res://cards/Card.tscn")
	cardBack = preload("res://cards/cardBack.png")
	cardCombat = preload("res://cards/cardCombat.png")
	cardGreedy = preload("res://cards/cardGreedy.png")
	cardMaze = preload("res://cards/cardMaze.png")
	cardPuzzle = preload("res://cards/cardPuzzle.png")
	cardTrap = preload("res://cards/cardTrap.png")

	var cards = []
	
	data = get_node("/root/ScenesData")
	
	var i
	var x = 220;
	for i in range(totalCards):
		var newCard 
		newCard = card.instance()
		newCard.set_pos(Vector2(x, 120))
		newCard.get_child(0).set_scale(Vector2(0.25, 0.25))
		newCard.get_child(0).set_texture(cardBack)
		randomize()
		var randomType = randi()%(totalTypes) + 1
		while(typesSorted.has(randomType)):
			randomize()
			randomType = randi()%(totalTypes) + 1
		print(randomType)
		typesSorted.append(randomType)
		newCard.cardType = randomType
		cards.append(newCard)
		AnimateCard(newCard)
		add_child(newCard)
		_create_timer(newCard, time + 5, true, "playFlip")	
		newCard.connect("finished_flip", self, "FlipSprite", [newCard])
		x += 250
		
func AnimateCard(card):
	_create_timer(card, time, true, "playAnim")	
	time += 1
	
func FlipCard(card):
	card.playFlip()
	card.get_node("AnimationPlayer").connect("finished", self, "FlipSprite", card)
	
func FlipSprite(card):
	totalFlipped += 1
	if(card.cardType == TYPE.combat):
		card.get_child(0).set_texture(cardCombat)
	elif(card.cardType == TYPE.greedy):
		card.get_child(0).set_texture(cardGreedy)
	elif(card.cardType == TYPE.maze):
		card.get_child(0).set_texture(cardMaze)
	elif(card.cardType == TYPE.puzzle):
		card.get_child(0).set_texture(cardPuzzle)
	elif(card.cardType == TYPE.trap):
		card.get_child(0).set_texture(cardTrap)
		
		
	if(totalFlipped == totalCards):
		_create_timer(self, 3.0, true, "goOn")
		data.first = typesSorted[0]
		data.second = typesSorted[1]
		data.third = typesSorted[2]
		
func goOn():
	data.loadNextScene()
	
func _wait(seconds):
    self._create_timer(self, seconds, true, "_emit_timer_end_signal")
    yield(self,"timer_end")

func _emit_timer_end_signal():
    emit_signal("timer_end")

func _create_timer(object_target, float_wait_time, bool_is_oneshot, string_function):
	var timer
	timer = Timer.new()
	timer.set_one_shot(bool_is_oneshot)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(float_wait_time)
	timer.connect("timeout", object_target, string_function)
	self.add_child(timer)
	timer.start()
