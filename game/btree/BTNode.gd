extends Node

const STATUS_FAILURE = 0
const STATUS_SUCCESS = 1
const STATUS_RUNNING = 2

var root

func _ready():
	root = get_BTRoot()

func get_BTRoot():
	if root != null:
		return root
	
	if get_parent() extends "BTNode.gd":
		return get_parent().get_BTRoot()
	
	return self

func tick(delta):
	return STATUS_SUCCESS