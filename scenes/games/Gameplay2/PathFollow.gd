extends PathFollow


const CLOUD_SCENE := preload("res://scenes/objects/clouds/Cloud/Cloud.tscn")


export var speed := 10.0

export var min_space_between_row := 80
export var space_between_row := 130
export var space_between_clouds := 15
export var clouds_hole := 3

onready var root := self.owner

var cloud_hole_size := clouds_hole * space_between_clouds * 0.5
var cloud_offset := 0.0
var cloud_popped := false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var offset = speed * delta
	self.offset += offset
	cloud_offset += offset
	
	if cloud_offset >= space_between_row:
		_generate_clouds()
		
		cloud_offset -= space_between_row
		if space_between_row > min_space_between_row:
			space_between_row -= min_space_between_row * 0.05
		else:
			space_between_row = min_space_between_row
		pass
	pass


func _generate_clouds():
	var hole : float = rand_range(-100.0, 100.0)
	
	for i in range(-100, 100, space_between_clouds):
		if abs(i - hole) > cloud_hole_size:
			var cloud := CLOUD_SCENE.instance()
			root.add_child(cloud)
			
			cloud.global_transform.origin = self.global_transform.origin
			cloud.global_transform.origin += $Pivot.global_transform.basis.x * i
			cloud.global_transform.origin -= $Pivot.global_transform.basis.z * 100
			pass
		pass
	pass
