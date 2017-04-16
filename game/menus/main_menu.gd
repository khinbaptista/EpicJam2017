extends TextureFrame

func _ready():
	get_tree().get_root().get_node("/root/bgm").play("MUSIC_MENU_AND_CREDITS")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") and not event.is_echo():
		load_next()

func load_next():
	get_tree().change_scene("res://menus/start_menu.tscn")
