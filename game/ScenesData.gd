extends Node

export var first = 0
export var second = 0
export var third = 0

var i = 0

func loadNextScene():
	if(i == 0):
		i += 1
		loadScene(first)
	elif(i == 1):
		i += 1
		loadScene(second)
	else:
		i += 1
		loadScene(third)
		
func loadScene(j):
	if(j == 1):
		get_tree().change_scene("res://dungeon/Dungeon_Combat1.tscn")
	elif(i == 2):
		get_tree().change_scene("res://dungeon/Dungeon_Greed1.tscn")
	elif(i == 3):
		get_tree().change_scene("res://dungeon/Dungeon_Maze1.tscn")
	elif(i == 4):
		get_tree().change_scene("res://dungeon/Dungeon_Puzzle1.tscn")
	elif(i == 5):
		get_tree().change_scene("res://dungeon/Dungeon_Trap1.tscn")
