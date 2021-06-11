extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	#global_transform.basis = Basis()
	
	#print("vspeed: ", linear_velocity.y)
	
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
