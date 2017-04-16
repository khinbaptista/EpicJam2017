extends Container

export(Texture) var heart_full
export(Texture) var heart_hollow

export(NodePath) var health_path
onready var health = get_node(health_path)

func _ready():
	health.value = 3
	health.connect("changed", self, "update_display")

func update_display():
	var hp = health.value
	
	for i in range(1, 4):
		if hp >= i:
			get_node("heart" + str(i)).set_texture(heart_full)
		else:
			get_node("heart" + str(i)).set_texture(heart_hollow)
