extends MeshInstance


var y_offset := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_as_toplevel(true)
	y_offset = self.global_transform.origin.y - get_parent().global_transform.origin.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	self.global_transform.origin = get_parent().global_transform.origin
	self.global_transform.origin.y = get_parent().global_transform.origin.y + y_offset
	
	pass
