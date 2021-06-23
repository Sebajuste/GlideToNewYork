extends PlayerState


var previous_camera


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func enter(_msg: Dictionary = {}):
	
	player.skin.get_node("Glider").visible = false
	player.skin.get_node("Cockpit").visible = true
	
	previous_camera = get_viewport().get_camera()
	
	player.skin.get_node("Cockpit").enable()
	
	pass


func exit():
	
	player.skin.get_node("Glider").visible = true
	player.skin.get_node("Cockpit").visible = false
	
	previous_camera.current = true
	
	pass


func process(delta):
	var cockpit = player.skin.get_node("Cockpit")
	cockpit.altitude = player.global_transform.origin.y
	cockpit.air_speed = player.velocity.length()
	


func physics_process(delta):
	
	process_input(delta)
	
	player.transform.basis = player.transform.basis.rotated(player.transform.basis.x, player.pitch_input * player.pitch_speed * delta)
	player.transform.basis = player.transform.basis.rotated(Vector3.UP, player.turn_input * player.turn_speed * delta)
	
	if player.grounded:
		player.skin.rotation.z = 0
	else:
		player.skin.rotation.z = lerp(player.skin.rotation.z, player.turn_input, player.level_speed * delta)
	
	if player.raycast_down.is_colliding():
		player.forward_speed = lerp(player.forward_speed, 0.0, player.deceleration * delta)
	else:
		player.forward_speed = lerp(player.forward_speed, player.target_speed, player.acceleration * delta)
	
	player.velocity = -player.transform.basis.z * player.forward_speed
	
	#player.velocity = player.move_and_slide(player.velocity, Vector3.UP)
	
	var collision = player.move_and_collide(player.velocity * delta)
	if collision:
		player.velocity = player.velocity.slide(collision.normal)
		
		if collision.collider.is_in_group("landing_zone"):
			
			player.transform.basis = Basis(Vector3.UP, player.transform.basis.get_euler().y )
			
		else:
			
			player.crash()
			
	
	
	# Handle landing/taking off
	if player.is_on_floor():
		if not player.grounded:
			player.rotation.x = 0
		player.velocity.z -= 1
		player.grounded = true
	else:
		player.grounded = false
	


func process_input(delta):
	# Throttle input*
	"""
	if Input.is_action_pressed("throttle_up"):
		player.target_speed = min(player.forward_speed + player.throttle_delta * delta, player.max_flight_speed)
	if Input.is_action_pressed("throttle_down"):
		var limit = 0 if player.grounded else player.min_flight_speed
		player.target_speed = max(player.forward_speed - player.throttle_delta * delta, limit)
	"""
	
	# Turn (roll/yaw) input
	player.turn_input = 0
	player.turn_input -= Input.get_action_strength("roll_right")
	player.turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	player.pitch_input = 0
	player.pitch_input -= Input.get_action_strength("pitch_down")
	player.pitch_input += Input.get_action_strength("pitch_up")
	
