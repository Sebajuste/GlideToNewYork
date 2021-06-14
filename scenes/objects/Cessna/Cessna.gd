extends StaticBody

export var max_speed : float = 0.5
export var max_force : float = 0.2
export var initial_force : float = 0#.01

export(NodePath) var path_follow_path

onready var path_follow := get_node(path_follow_path)

var position : Vector3
var velocity : Vector3 = Vector3(0, 0, 0)
var acceleration : Vector3 = Vector3(0, 0, 0)

func _ready():
	path_follow.connect("end_of_path", self, "_on_end_of_path")
	_apply_force(Vector3(initial_force, 0, 0))
	position = self.global_transform.origin
	#path_follow.unit_offset = 0.1
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
		print("p=" + str(position) + ", v=" + str(velocity) + ", s=" + str(steering) + ", uo=" + str(path_follow.unit_offset))
		pass
	
	self.global_transform.origin = position
	
	pass


func _on_end_of_path():
	path_follow._generate_curve(global_transform.origin)
	pass


func vector3Limit(vec : Vector3, maxLength : float) -> Vector3 :
	var v := Vector3(vec.x, vec.y, vec.z)
	if v.length() > maxLength:
		v = v.normalized() * maxLength
	return v
