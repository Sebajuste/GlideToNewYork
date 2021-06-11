extends StaticBody



export var max_speed := 0.5
export var acceleration := 0.3



export(NodePath) var path_follow_path


onready var path_follow := get_node(path_follow_path)


var speed := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	# set_as_toplevel(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	speed = lerp(speed, max_speed, acceleration * delta)
	
	
	if path_follow:
		path_follow.offset = path_follow.offset + speed
		
		self.global_transform.origin = path_follow.global_transform.origin
	

