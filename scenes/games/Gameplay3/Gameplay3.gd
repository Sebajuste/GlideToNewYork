extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player := $Player


var height_limited := true

var ending := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	if player.velocity.length_squared() < 1.0 and player.raycast_down.is_colliding():
		
		var collider = player.raycast_down.get_collider()
		
		if collider.is_in_group("landing_zone"):
			
			LevelManager.next_level()
			
	
	if not ending and player.global_transform.origin.y > 200 and height_limited:
		ending = true
		LevelManager.restart_level("Votre planneur a été repéré")
		
	


func _on_Area_body_entered(body):
	
	height_limited = false
	


func _on_Area_body_exited(body):
	
	height_limited = true
	


func _on_Player_crashed():
	
	LevelManager.restart_level("Votre planneur s'est écrasé")
	
