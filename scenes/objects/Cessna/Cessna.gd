extends StaticBody

export var max_speed := 0.5
export var acceleration := 0.3

export(NodePath) var path_follow_path

onready var path_follow := get_node(path_follow_path)

var speed := 0.0


func _ready():
	path_follow.connect("end_of_path", self, "_on_end_of_path")
	pass



func _physics_process(delta):
	
	speed = lerp(speed, max_speed, acceleration * delta)
	
	
	if path_follow:
		path_follow.offset = path_follow.offset + speed
		
		self.global_transform.origin = path_follow.global_transform.origin
	




func _on_end_of_path():
	path_follow._generate_curve(global_transform.origin)
	pass
