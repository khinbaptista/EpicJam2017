extends Node

var totalCards = 10
var card

func _ready():
	card = preload("res://cards/Card.tscn")

	var cards = []
	
	var i
	var y = 0;
	for i in range(totalCards):
		var newCard 
		newCard = card.instance()
		newCard.set_pos(Vector2(y, 100))
		cards.append(newCard)
		add_child(newCard)
		y += 100
