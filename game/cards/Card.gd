extends Node2D

signal finished_flip

export var cardType = 0

func _ready():
	pass
	
func playAnim():
	self.get_child(1).play("move")

func playFlip():
	self.get_child(1).play("flip")
	
func endFlip():
	emit_signal("finished_flip")