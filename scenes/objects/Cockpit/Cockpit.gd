tool
extends Spatial

export var altitude := 0 setget set_altitude
export var air_speed := 0 setget set_air_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	$FrontCameraViewport/Camera.global_transform = $FrontCameraPosition.global_transform
	$RightCameraViewport/Camera.global_transform = $RightCameraPosition.global_transform
	$LeftCameraViewport/Camera.global_transform = $LeftCameraPosition.global_transform
	


func enable():
	
	$Camera.current = true
	
	$AnimationPlayer.play("zoom")
	


func set_altitude(value):
	altitude = value
	$FrontCameraViewport/MainScreenCockpit.altitude = altitude


func set_air_speed(value):
	air_speed = value
	$FrontCameraViewport/MainScreenCockpit.speed = air_speed
