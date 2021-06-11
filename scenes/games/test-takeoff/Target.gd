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


func _unhandled_input(event):
	
	if event.is_action_pressed("ui_select"):
		
		var chain := $"../Chain/"
		
		if chain.has_node("PinJoint7"):
			chain.get_node("PinJoint7").queue_free()
		
		
	


func _physics_process(delta):
	
	
	
	# add_central_force(Vector3.UP * delta * 100)
	pass


func _integrate_forces(state : PhysicsDirectBodyState) -> void:
	
	var pitch_up := Input.get_action_strength("pitch_up")
	
	add_central_force(Vector3.UP * pitch_up * 100)
	
	pass
