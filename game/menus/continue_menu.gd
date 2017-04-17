extends Control

export(PackedScene) var next_scene

onready var button_continue	= get_node("try_again")
onready var button_quit		= get_node("quit")

var focused_button

func _ready():
	button_continue.connect("pressed", self, "pressed_continue")
	button_quit.connect("pressed", self, "pressed_quit")
	
	button_continue.connect("mouse_enter", self, "changed_focus", [button_continue])
	button_quit.connect("mouse_enter", self, "changed_focus", [button_quit])
	
	changed_focus(button_continue)
	
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_up") and not event.is_echo():
		changed_focus(button_continue)
	
	elif event.is_action_pressed("ui_down") and not event.is_echo():
		changed_focus(button_quit)
	
	elif event.is_action_pressed("ui_accept") and not event.is_echo():
		focused_button.emit_signal("pressed")

func changed_focus(button):
	if focused_button != null:
		focused_button.get_node("focus").hide()
	
	focused_button = button
	focused_button.get_node("focus").show()

func pressed_continue():
	get_node("/root/ScenesData").i = 0
	get_tree().change_scene_to(next_scene)

func pressed_quit():
	get_tree().quit()
