extends Path

export var delta_height_max : float = 100
export var delta_length_max : float = 1000.0
export var delta_length_min : float = 500.0
export var max_in_out : float = 30.0
export var min_in_out : float = 10.0
export var random_seed : int = 0

var rnd := RandomNumberGenerator.new()


func _ready():
	rnd.seed = random_seed
	pass


func _generate_curve(newOrigin : Vector3):
	print("new curve")
	
	# move the origin of the new curve, add a first point at position 0, 0, 0.
	global_transform.origin = newOrigin
	var curve := Curve3D.new()
	curve.add_point(Vector3(0, 0, 0), Vector3(0, 0, 0), Vector3(0, 0, 0))
	
	# Then generate a new destination and in / out points
	var vecPos : Vector3 = _get_random_destination()
	var vecIn : Vector3 = _get_random_in()
	var vecOut : Vector3 = _get_random_out()
	
	curve.add_point(vecPos, vecIn, vecOut)
	
	set_curve(curve)
	pass

func _get_random_destination() -> Vector3:
	var deltaHeight: float = rnd.randf_range(-delta_height_max, delta_height_max)
	var deltaLength: float = rnd.randf_range(delta_length_min, delta_length_max)
	
	# TODO : verify that the delta height don't send the plane into the ground !
	
	return Vector3(deltaLength, deltaHeight, 0)
	
func _get_random_in() -> Vector3:
	var rndInX: float = rnd.randf_range(-max_in_out, min_in_out)
	var rndInY: float = rnd.randf_range(-max_in_out, min_in_out)
	return Vector3(rndInX, rndInY, 0)

func _get_random_out() -> Vector3:
	var rndOutX: float = rnd.randf_range(min_in_out, max_in_out)
	var rndOutY: float = rnd.randf_range(min_in_out, max_in_out)
	return Vector3(rndOutX, rndOutY, 0)
