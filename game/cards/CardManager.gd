extends Node

signal timer_end

enum TYPE{
	combat = 1,
	greedy = 2,
	maze = 3,
	puzzle = 4,
	trap = 5
}

var totalCards = 5
var card
var time = 1

var cardBack
var cardCombat

func _ready():
	card = preload("res://cards/Card.tscn")
	cardBack = preload("res://cards/cardBack.png")
	cardCombat = preload("res://cards/cardCombat.png")

	var cards = []
	
	var i
	var y = 60;
	for i in range(totalCards):
		var newCard 
		newCard = card.instance()
		newCard.set_pos(Vector2(y, 100))
		newCard.get_child(0).set_scale(Vector2(0.15, 0.15))
		newCard.get_child(0).set_texture(cardBack)
		newCard.cardType = randi()%(totalCards + 1) + 1
		cards.append(newCard)
		AnimateCard(newCard)
		add_child(newCard)
		_create_timer(newCard, time + 5, true, "playFlip")	
		newCard.connect("finished_flip", self, "FlipSprite", [newCard])
		y += 100
		
func AnimateCard(card):
	_create_timer(card, time, true, "playAnim")	
	time += 1
	
func FlipCard(card):
	card.playFlip()
	card.get_node("AnimationPlayer").connect("finished", self, "FlipSprite", card)
	
func FlipSprite(card):
	if(card.cardType == TYPE.combat):
		card.get_child(0).set_texture(cardCombat)
	elif(card.cardType == TYPE.greedy):
		card.get_child(0).set_texture(cardCombat)
	elif(card.cardType == TYPE.maze):
		card.get_child(0).set_texture(cardCombat)
	elif(card.cardType == TYPE.puzzle):
		card.get_child(0).set_texture(cardCombat)
	elif(card.cardType == TYPE.trap):
		card.get_child(0).set_texture(cardCombat)
	
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
