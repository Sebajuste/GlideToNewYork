extends StaticBody

export var max_speed : float = 0.5
export var max_force : float = 0.2

export(NodePath) var path_follow_path

onready var path_follow := get_node(path_follow_path)

var look_ahead_distance : float = 100
var position : Vector3 = Vector3.ZERO
var velocity : Vector3 = Vector3.ZERO
var acceleration : Vector3 = Vector3.ZERO

func _ready():
	path_follow.connect("end_of_path", self, "_on_end_of_path")
	position = self.global_transform.origin
	path_follow.offset = look_ahead_distance
	pass

func _apply_force(force : Vector3):
	force = vector3Limit(force, max_force)
	acceleration += force
	pass


func _physics_process(delta):
	velocity += acceleration
	velocity = vector3Limit(velocity, max_speed)
	position += velocity
	acceleration *= 0
	
	if path_follow:
		path_follow.offset += velocity.length() * 1.2
		var target : Vector3 = path_follow.global_transform.origin
		var desired : Vector3 = target - position
		desired = desired.normalized() * max_speed
		var steering : Vector3 = desired - velocity
		_apply_force(steering)
		#print("p=" + str(position) + ", t=" + str(target) + ", s=" + str(steering) + ", uo=" + str(path_follow.unit_offset))
		#print("p=" + str(position) + ", v=" + str(velocity) + ", s=" + str(steering) + ", uo=" + str(path_follow.unit_offset))
		pass
	
	self.global_transform.origin = position
	
	pass


func _on_end_of_path():
	path_follow._generate_curve(global_transform.origin)
	path_follow.offset = look_ahead_distance
	pass


func vector3Limit(vec : Vector3, maxLength : float) -> Vector3 :
	var v := Vector3(vec.x, vec.y, vec.z)
	if v.length() > maxLength:
		v = v.normalized() * maxLength
	return v
