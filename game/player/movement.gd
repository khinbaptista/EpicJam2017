extends Node

var player
var movement_attr

var anim_player;

func _ready():
	player = get_parent()
	movement_attr = player.get_node("attributes/movement_speed")
	anim_player = get_parent().get_node("AnimationPlayer");
	set_fixed_process(true)

func _fixed_process(delta):
	
	if(anim_player.is_playing() && anim_player.get_current_animation().ends_with("attack")):
		return;
	
	var movement = Vector2()
	
	if Input.is_action_pressed("move_up"):
		movement.y -= 1.0
	if Input.is_action_pressed("move_down"):
		movement.y += 1.0
	if Input.is_action_pressed("move_left"):
		movement.x -= 1.0
	if Input.is_action_pressed("move_right"):
		movement.x += 1.0
	
	if(!anim_player.is_playing()):
		anim_player.play("movement")
	
	if movement == Vector2(): 
		return
	
	movement = movement.normalized()
	
	var angle = player.get_angle_to(player.get_global_pos() + movement);
	player.rotate(angle * delta * 10);
	#player.look_at(player.get_global_pos() + movement)
	var remaining = player.move(movement * movement_attr.value * delta)
	
	if player.is_colliding():
		var normal = player.get_collision_normal()
		var remaining = remaining.slide(normal)
		player.move(remaining)
