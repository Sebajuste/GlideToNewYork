extends StaticBody

signal first_move

export var max_speed : float = 0.6
export var max_force : float = 0.2

export(NodePath) var path_follow_path

onready var path_follow : Spatial = get_node(path_follow_path)

var startedMoves : bool = false
var look_ahead_distance : float = 50
var position : Vector3 = Vector3.ZERO
var velocity : Vector3 = Vector3.ZERO
#var acceleration : Vector3 = Vector3.ZERO

export var acceleration := 0.1
var speed := 0.0


func _ready():
	position = self.global_transform.origin
	pass

"""
func _apply_force(force : Vector3):
	force = vector3Limit(force, max_force)
	#acceleration += force
	pass
"""

func _physics_process(delta):
	#velocity += acceleration
	#velocity = vector3Limit(velocity + acceleration, max_speed)
	
	
	var force := Vector3.ZERO
	
	if path_follow:
		#var speed := 
		path_follow.offset += max_speed # velocity.length()
		
		var target := path_follow.global_transform.origin
		#var desired := target - position
		
		"""
		while desired.length() < look_ahead_distance:
			path_follow.offset += look_ahead_distance
			target = path_follow.global_transform.origin
			desired = target - position
		"""
		
		#desired = desired.normalized() * max_speed
		var steering : Vector3 = target - velocity
		#_apply_force(steering)
		force = vector3Limit(target, max_force)
		
		"""
		if !startedMoves:
			startedMoves = true
			var initialAccel : Vector3 = Vector3(acceleration)
			initialAccel = initialAccel.normalized() * max_speed
			emit_signal("first_move", initialAccel / delta)
			
		"""
	
	
	speed = lerp(speed, max_speed, acceleration * delta)
	
	velocity = transform.basis.x * speed
	
	velocity += force
	
	position += velocity
	#acceleration = Vector3.ZERO
	
	
	
	self.global_transform.origin = position
	pass


func vector3Limit(vec : Vector3, maxLength : float) -> Vector3 :
	var v := Vector3(vec.x, vec.y, vec.z)
	if v.length() > maxLength:
		v = v.normalized() * maxLength
	return v


func _on_CessnaPathFollow_end_of_path():
	path_follow._generate_curve(global_transform.origin)
	pass
