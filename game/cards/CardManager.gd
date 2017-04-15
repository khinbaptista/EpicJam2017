extends Node

signal timer_end

var totalCards = 10
var card
var time = 1

func _ready():
	card = preload("res://cards/Card.tscn")

	var cards = []
	
	var i
	var y = 0;
	for i in range(totalCards):
		var newCard 
		newCard = card.instance()
		newCard.set_pos(Vector2(y, 100))
		newCard.cardType = randi()%(totalCards + 1) + 1
		cards.append(newCard)
		AnimateCard(newCard)
		add_child(newCard)
		y += 100
		
func AnimateCard(card):
	_create_timer(card, time, true, "playAnim")	
	time += 1
	
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
