class_name Player
extends KinematicBody


const GRAVITY := 9.81


# Can't fly below this speed
var min_flight_speed = 10
# Maximum airspeed
var max_flight_speed = 30
# Turn rate
var turn_speed = 0.75
# Climb/dive rate
var pitch_speed = 0.5
# Wings "autolevel" speed
var level_speed = 3.0
# Throttle change speed
var throttle_delta = 30
# Acceleration/deceleration
var acceleration = 6.0

# Current speed
var forward_speed = 0
# Throttle input speed
var target_speed = 30
# Lets us change behavior when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0

export(String, "None", "Gameplay1", "Gameplay2", "Gameplay3") var control_mode = "None" setget set_control_mode

onready var skin := $Skin
onready var control: StateMachine = $ControlSM


# Called when the node enters the scene tree for the first time.
func _ready():
	print("test ", control_mode)
	if control_mode:
		control.transition_to("Control/%s" % control_mode)
	else:
		control.transition_to("Control/None")
	
	pass # Replace with function body.


func _unhandled_input(event):
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func set_control_mode(value):
	control_mode = value
	if control:
		print("set control to %s" % value)
		control.transition_to("Control/%s" % value)


"""
func _physics_process(delta):
	
	process_input(delta)
	
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	
	if grounded:
		$Skin.rotation.z = 0
	else:
		$Skin.rotation.z = lerp($Skin.rotation.z, turn_input, level_speed * delta)
	
	forward_speed = lerp(forward_speed, target_speed, acceleration * delta)
	velocity = -transform.basis.z * forward_speed
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
	# Handle landing/taking off
	if is_on_floor():
		if not grounded:
			rotation.x = 0
		velocity.z -= 1
		grounded = true
	else:
		grounded = false
	
	pass


func process_input(delta):
	# Throttle input
	if Input.is_action_pressed("throttle_up"):
		target_speed = min(forward_speed + throttle_delta * delta, max_flight_speed)
	if Input.is_action_pressed("throttle_down"):
		var limit = 0 if grounded else min_flight_speed
		target_speed = max(forward_speed - throttle_delta * delta, limit)
	
	# Turn (roll/yaw) input
	turn_input = 0
	turn_input -= Input.get_action_strength("roll_right")
	turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	pitch_input = 0
	pitch_input -= Input.get_action_strength("pitch_down")
	pitch_input += Input.get_action_strength("pitch_up")
"""
