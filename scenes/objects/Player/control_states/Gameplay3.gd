extends PlayerState



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func physics_process(delta):
	
	process_input(delta)
	
	player.transform.basis = player.transform.basis.rotated(player.transform.basis.x, player.pitch_input * player.pitch_speed * delta)
	player.transform.basis = player.transform.basis.rotated(Vector3.UP, player.turn_input * player.turn_speed * delta)
	
	if player.grounded:
		player.skin.rotation.z = 0
	else:
		player.skin.rotation.z = lerp(player.skin.rotation.z, player.turn_input, player.level_speed * delta)
	
	player.forward_speed = lerp(player.forward_speed, player.target_speed, player.acceleration * delta)
	player.velocity = -player.transform.basis.z * player.forward_speed
	player.velocity = player.move_and_slide(player.velocity, Vector3.UP)
	
	
	# Handle landing/taking off
	if player.is_on_floor():
		if not player.grounded:
			player.rotation.x = 0
		player.velocity.z -= 1
		player.grounded = true
	else:
		player.grounded = false
	


func process_input(delta):
	# Throttle input
	if Input.is_action_pressed("throttle_up"):
		player.target_speed = min(player.forward_speed + player.throttle_delta * delta, player.max_flight_speed)
	if Input.is_action_pressed("throttle_down"):
		var limit = 0 if player.grounded else player.min_flight_speed
		player.target_speed = max(player.forward_speed - player.throttle_delta * delta, limit)
	
	# Turn (roll/yaw) input
	player.turn_input = 0
	player.turn_input -= Input.get_action_strength("roll_right")
	player.turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	player.pitch_input = 0
	player.pitch_input -= Input.get_action_strength("pitch_down")
	player.pitch_input += Input.get_action_strength("pitch_up")
