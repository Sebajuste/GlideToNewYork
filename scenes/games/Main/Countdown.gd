extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hours := 20
var minutes := 17
var seconds := 43


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	
	pass


func _on_Timer_timeout():
	
	seconds -= 1
	
	if seconds < 0:
		seconds = 59
		minutes -= 1
	
	if minutes < 0:
		minutes = 59
		hours -= 1
	
	pass # Replace with function body.
