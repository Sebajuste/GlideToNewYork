extends PlayerState



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func physics_process(delta):
	
	# Turn (roll/yaw) input
	player.turn_input = 0
	player.turn_input -= Input.get_action_strength("roll_right")
	player.turn_input += Input.get_action_strength("roll_left")
	
	#player.transform.basis = player.transform.basis.rotated(Vector3.UP, player.turn_input * player.turn_speed * delta)
	
	
	
	player.skin.rotation.z = lerp(player.skin.rotation.z, player.turn_input, player.level_speed * delta)
	
	player.forward_speed = lerp(player.forward_speed, player.target_speed, player.acceleration * delta)
	
	
	player.transform.origin += -player.transform.basis.x * player.turn_input * 100 * delta
	
	
	#player.velocity = Vector3.ZERO
	#player.velocity += -player.transform.basis.x * player.turn_input * player.turn_speed * 100
	#player.velocity += -player.transform.basis.z * player.forward_speed
	#player.velocity = player.move_and_slide(player.velocity, Vector3.UP)
	
