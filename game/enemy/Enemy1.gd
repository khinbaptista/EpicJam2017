extends KinematicBody2D

var fsm = null;
var particle = null;
var anim_player = null;
var dir = Vector2(0,0);

export(float, 0, 1000, 2) var speed = 10;

export(float, 0, 2, 0.1) var atk_delay = 1;
var atkdelay_c = 0.0;
var currAtk = null;

export(NodePath) var level_path
onready var level = get_node(level_path)

var PlayerClass = preload("res://player/player.gd")
var attack_scene = preload("attack.tscn") 

func _ready():
	set_process(true);
	
	particle = get_node("Particles2D");
	anim_player = get_node("AnimationPlayer");
	fsm = get_node("StateMachine");
	
	get_node("sfx").play("idle")
	
func _process(delta):
	#process_input();
	#move(Vector2(dir.x * speed * delta, dir.y * speed * delta));
	process_particles(dir, delta);
	process_knockback(delta)
	#handle_fsm();
	if(atkdelay_c < atk_delay):
		atkdelay_c += delta;
		if(atkdelay_c >= atk_delay && currAtk != null):
			currAtk.resume()
	
func handle_fsm():
	if(!anim_player.is_playing()):
		return
		
	var anim_name = anim_player.get_current_animation();
	var anim_pos = anim_player.get_current_animation_pos();
	if(anim_name == "attack"):
		if(anim_pos > 0 && anim_pos < 2.5):
			fsm.set_current_state("Attacking")
		else:
			fsm.set_current_state("Idle")
	
func process_input():
	dir = Vector2(0,0);
	if(Input.is_action_pressed("ui_down")):
		dir.y = 1;
	elif(Input.is_action_pressed("ui_up")):
		dir.y = -1;
	if(Input.is_action_pressed("ui_right")):
		dir.x = 1;
	elif(Input.is_action_pressed("ui_left")):
		dir.x = -1;
	
	if(Input.is_action_pressed("ui_accept")):
		attack();
	
	dir = dir.normalized();
	
var lerp_w = 0;
func process_particles(dir, delta):
	if(fsm.current_state.name == "Attacking"):
		return;

	if(dir.length() > 0):
		if(lerp_w > 0.05):
			lerp_w -= 3 * delta;
		particle.set_param(particle.PARAM_GRAVITY_DIRECTION, rad2deg(dir.angle()) + 180);
	else:
		if(lerp_w < 1):
			lerp_w += 3 * delta;
	
	particle.set_param(particle.PARAM_GRAVITY_STRENGTH, lerp(1000, 0, lerp_w));
	particle.set_param(particle.PARAM_LINEAR_VELOCITY, lerp(100, 300, lerp_w));
	particle.set_param(particle.PARAM_ORBIT_VELOCITY, lerp(0, 5, lerp_w));
	
func attack(target):
	look_at(target.get_global_pos())
	anim_player.play("attack");
	yield()
	instance_attack(target)

func instance_attack(target):
	var attack_node = attack_scene.instance()
	attack_node.target = target
	attack_node.damage = get_node("attributes/damage").value
	get_node("attacks").add_child(attack_node)

signal death
func hit(damage, player=null):
	get_node("sfx").play("hit")
	
	var health = get_node("attributes/health")
	health.value -= damage
	
	if(player != null):
		player.shake_screen(damage, 0.15)
		
	
	printt("Enemy hit!", damage, health.value)
	
	if health.value == 0:
		get_node("sfx").stop_all(); get_node("sfx").play("death")
		emit_signal("death")
		queue_free()

var onKnockback = false
var knbk_str = 0.0
var knbk_falloff = 2000.0
var knbk_dir = Vector2()
func knockback(dir, strength):
	onKnockback = true
	knbk_str = strength
	knbk_dir = dir
	
func process_knockback(delta):
	if(onKnockback):
		move(knbk_dir * knbk_str * delta)
		knbk_str -= knbk_falloff * delta
		if(knbk_str <= 0):
			knbk_str = 0
			onKnockback = false
		pass
		
func on_body_enter(body):
	if body extends PlayerClass:
		fsm.get_node("Seeking").target = body
		fsm.make_transition("seek")
