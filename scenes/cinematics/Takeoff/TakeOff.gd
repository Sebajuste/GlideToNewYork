extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$AnimationPlayer.play("takeoff")
	
	$Cessna.set_physics_process(false)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func glider_takeoff():
	
	$Glider.impusle = Vector3.UP * 5
	
	pass


func end_level():
	
	LevelManager.next_level()
	
