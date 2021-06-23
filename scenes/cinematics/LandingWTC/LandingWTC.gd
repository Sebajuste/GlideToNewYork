extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var main = get_tree().get_root().get_node("Main")
	
	if main:
		main.stop_music()
	
	var tween = $Music/Tween
	tween.interpolate_property($Music, "volume_db",
		-80, 0, 3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	
	$Camera1.current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
