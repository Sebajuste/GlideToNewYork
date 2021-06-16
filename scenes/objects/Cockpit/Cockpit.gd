tool
extends Spatial


var camera_front : Camera
var camera_right : Camera
var camera_left : Camera

var camera_front_offset : Transform
var camera_right_offset : Transform
var camera_left_offset : Transform


# Called when the node enters the scene tree for the first time.
func _ready():
	
	camera_front = get_node("FrontCameraViewport/Camera")
	camera_right = get_node("RightCameraViewport/Camera")
	camera_left = get_node("LeftCameraViewport/Camera")
	
	camera_right_offset = camera_right.transform
	camera_left_offset = camera_left.transform
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	camera_front.global_transform = $FrontCameraPosition.global_transform
	$RightCameraViewport/Camera.global_transform = $RightCameraPosition.global_transform
	$LeftCameraViewport/Camera.global_transform = $LeftCameraPosition.global_transform
	
	
	#camera_right.global_transform = self.global_transform * camera_right_offset
	#camera_left.global_transform = self.global_transform * camera_left_offset
	
	pass

"""
	if camera_front_offset:
		camera_front.global_transform = self.global_transform 
	else:
		camera_front.global_transform = self.global_transform
"""


func enable():
	
	$Camera.current = true
	
	$AnimationPlayer.play("zoom")
	
