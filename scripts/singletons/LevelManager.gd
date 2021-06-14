extends Node


signal next_level_called


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func next_level():
	
	emit_signal("next_level_called")
	
	pass


