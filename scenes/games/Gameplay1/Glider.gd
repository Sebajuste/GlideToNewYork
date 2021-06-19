extends RigidBody

signal force_updated

var last_speed := 0.0


onready var cessna := $"../Cessna"


func _ready():
	pass


func _physics_process(delta : float):
	
	var speed := linear_velocity.length()
	
	var force := abs(speed - last_speed) / delta
	last_speed = speed
	
	emit_signal("force_updated", force)
	


func _unhandled_input(event):
	
	if event.is_action_pressed("ui_select"):
		var chain := $"../Chain/"
		if chain.has_node("PinJoint7"):
			chain.get_node("PinJoint7").queue_free()
		


func _integrate_forces(state : PhysicsDirectBodyState) -> void:
	
	var pitch_up := Input.get_action_strength("pitch_up")
	
	add_central_force(Vector3.UP * pitch_up * 100)
	
	state.angular_velocity = Vector3.ZERO
	state.linear_velocity.z = 0
	
	var height_delta : float = cessna.global_transform.origin.y - self.global_transform.origin.y
	
	if owner.started and height_delta > 2:
		
		state.apply_central_impulse(Vector3.UP * randf() * height_delta )
		
	


