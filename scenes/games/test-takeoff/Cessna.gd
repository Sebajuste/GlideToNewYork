extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_speed := 30.0
export var acceleration := 1.0

var speed := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	self.global_transform.origin = $"../Path/PathFollow".global_transform.origin
	
	#$"../Path/PathFollow".offset += speed
	#self.global_transform.origin = $"../Path/PathFollow".global_transform.origin
