extends Spatial

export(float, 0.0, 100.0) var max_distance := 100 setget set_max_distance
export(float, 0.0, 50.0) var cloud_density := 25.0 setget set_cloud_density
export(float, 0.0, 50.0) var light_density := 25.0 setget set_light_density

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_max_distance(value):
	max_distance = clamp(value, 0.0, 100.0)
	$Worley_texture.max_distance = value / 100.01


func set_cloud_density(value):
	cloud_density = clamp(value, 0.0, 50.0)
	$Cube.get_surface_material(0).set_shader_param("cloud_density_factor", cloud_density)

func set_light_density(value):
	light_density = clamp(value, 0.0, 50.0)
	$Cube.get_surface_material(0).set_shader_param("light_density_factor", light_density)
