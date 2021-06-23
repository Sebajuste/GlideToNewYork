extends PlayerState

export var speed := 100

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
	
	player.skin.rotation.z = lerp(player.skin.rotation.z, player.turn_input, player.level_speed * delta)
	
	player.forward_speed = lerp(player.forward_speed, player.target_speed, player.acceleration * delta)
	
	
	#player.transform.origin += -player.transform.basis.x * player.turn_input * 100 * delta
	
	var collide = player.move_and_collide(-player.global_transform.basis.x * player.turn_input * speed * delta)
	
	if collide:
		var collider = collide.get_collider()
		
		if collider.is_in_group("obstacle"):
			
			player.crash()
			
