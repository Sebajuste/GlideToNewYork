extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_speed := 10.0
export var acceleration := 1.0


var speed := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	speed = lerp(speed, max_speed, acceleration * delta)
	
	move_and_slide(Vector3.RIGHT * speed)
	
	
