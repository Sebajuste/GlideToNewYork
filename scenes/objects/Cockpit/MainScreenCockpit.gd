extends CanvasLayer



export var altitude := 1234
export var speed := 321



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Control/HBoxContainer/Altitude.text = "Alt : %d, " % altitude
	$Control/HBoxContainer/Air.text = "Air: %d" % speed
	
