extends Node2D

export var cardType = 0

func _ready():
	pass
	
func playAnim():
	self.get_child(1).play("move")
