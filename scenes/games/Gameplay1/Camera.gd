extends Camera


export var camera_speed := 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	var pos = ($"../Cessna".global_transform.origin - $"../Glider".global_transform.origin) / 2
	
	pos +=  $"../Glider".global_transform.origin
	pos.z = 27
	
	self.global_transform.origin = lerp(self.global_transform.origin, pos, camera_speed * delta)
	
	
	#$WorleyCloud.cloud_density = pos.y / 30
	
