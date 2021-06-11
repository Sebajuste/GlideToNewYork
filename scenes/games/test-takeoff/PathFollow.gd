extends PathFollow


export var max_speed := 0.5

var speed := 0.0
var acceleration := 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	speed = lerp(speed, max_speed, acceleration * delta)
	
	offset = offset + speed
	
