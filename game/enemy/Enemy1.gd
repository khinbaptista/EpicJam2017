extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var particle = null;
var dir = Vector2(0,0);

export(float, 0, 1000, 2) var speed = 10;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	particle = get_node("Particles2D");
	pass
	
func _process(delta):
	process_input();
	move(Vector2(dir.x * speed * delta, dir.y * speed * delta));
	process_particles(dir, delta);
	
	
	pass
	
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
	
	dir = dir.normalized();
	pass
	
var lerp_w = 0;
func process_particles(dir, delta):
	if(dir.length() > 0):
		lerp_w = 0
		particle.set_param(particle.PARAM_GRAVITY_DIRECTION, rad2deg(dir.angle()) + 180);
		particle.set_param(particle.PARAM_GRAVITY_STRENGTH, 800);
		particle.set_param(particle.PARAM_LINEAR_VELOCITY, 100);
		particle.set_param(particle.PARAM_ORBIT_VELOCITY, 0);
		pass
	else:
		particle.set_param(particle.PARAM_GRAVITY_STRENGTH, lerp(800, 0, lerp_w));
		particle.set_param(particle.PARAM_LINEAR_VELOCITY, lerp(100, 500, lerp_w));
		particle.set_param(particle.PARAM_ORBIT_VELOCITY, lerp(0, 10, lerp_w));
	
	if(lerp_w < 1):
		lerp_w += 2 * delta;
	pass