class_name Player
extends KinematicBody


signal crashed


const GRAVITY := 9.81


# Can't fly below this speed
export var min_flight_speed = 10
# Maximum airspeed
export var max_flight_speed = 30
# Turn rate
export var turn_speed = 0.75
# Climb/dive rate
export var pitch_speed = 0.5
# Wings "autolevel" speed
export var level_speed = 3.0
# Throttle change speed
export var throttle_delta = 30
# Acceleration/deceleration
export var acceleration = 6.0
export var deceleration = 0.5

export(String, "None", "Gameplay1", "Gameplay2", "Gameplay3") var control_mode = "None" setget set_control_mode

# Current speed
var forward_speed = 0
# Throttle input speed
var target_speed = 30
# Lets us change behavior when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0

var alive := true

onready var skin := $Skin
onready var control: StateMachine = $ControlSM
onready var raycast_down : RayCast = $RayCast

# Called when the node enters the scene tree for the first time.
func _ready():
	if control_mode:
		control.transition_to("Control/%s" % control_mode)
	else:
		control.transition_to("Control/None")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func crash():
	if alive:
		alive = false
		emit_signal("crashed")
		$CrashAudio.play()


func set_control_mode(value):
	control_mode = value
	if control:
		print("set control to %s" % value)
		control.transition_to("Control/%s" % value)
