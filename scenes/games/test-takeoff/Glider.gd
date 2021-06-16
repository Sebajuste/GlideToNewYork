extends RigidBody



func _ready():
	pass

func _physics_process(delta):
	pass


func _unhandled_input(event):
	
	if event.is_action_pressed("ui_select"):
		var chain := $"../Chain/"
		if chain.has_node("PinJoint7"):
			chain.get_node("PinJoint7").queue_free()
		

var old_linear_velocity := Vector3.ZERO

func _integrate_forces(state : PhysicsDirectBodyState) -> void:
	
	var pitch_up := Input.get_action_strength("pitch_up")
	
	add_central_force(Vector3.UP * pitch_up * 100)
	
	state.angular_velocity = Vector3.ZERO
	state.linear_velocity.z = 0
	
	#print("linear_velocity: ", (state.linear_velocity - old_linear_velocity).length() )
	
	old_linear_velocity = state.linear_velocity
	
	pass


func _on_Cessna_first_move(v : Vector3):
	set_linear_velocity(v)
	pass
	
