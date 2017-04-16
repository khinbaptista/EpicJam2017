extends Node

var player setget set_player

func set_player(p):
	player = p
	player.connect("death", self, "on_player_death")

func on_player_death():
	get_tree().change_scene("res://scenes/game_over.tscn")
