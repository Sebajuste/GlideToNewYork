extends Path

export var delta_height_max: float = 1000.0
export var delta_length_max: float = 1000.0
export var max_in_out: float = 50.0
export var random_seed := 0

var rnd := RandomNumberGenerator.new()



func _ready():
	rnd.seed = random_seed
	pass


func _generate_curve(start):
	global_transform.origin = start
	var curve := Curve3D.new()
	curve.add_point(Vector3(0, 0, 0), Vector3(0, 0, 0), Vector3(0, 0, 0))
	
	var rndInX: float = rnd.randf_range(-max_in_out, max_in_out)
	var rndInY: float = rnd.randf_range(-max_in_out, max_in_out)
	var rndOutX: float = rnd.randf_range(-max_in_out, max_in_out)
	var rndOutY: float = rnd.randf_range(-max_in_out, max_in_out)
	var deltaHeight: float = rnd.randf_range(-delta_height_max, delta_height_max)
	var deltaLength: float = rnd.randf_range(-delta_length_max, delta_length_max)
	
	var vecIn: Vector3 = Vector3(rndInX, rndInY, 0)
	var vecOut: Vector3 = Vector3(rndOutX, rndOutY, 0)
	
	curve.add_point(Vector3(deltaLength, deltaHeight, 0), vecIn, vecOut)
	set_curve(curve)
	pass
