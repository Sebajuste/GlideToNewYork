extends Spatial


export var max_force := 5.0


var started := false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$CanvasLayer/UI/Force/ProgressBar.max_value = (max_force / 3) * 2
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Glider_force_updated(force):
	
	if started:
		if force > max_force:
			var chain := $Chain
			if chain.has_node("PinJoint7"):
				chain.get_node("PinJoint7").queue_free()
			$RestartTimer.start()
		
		$CanvasLayer/UI/Force/ProgressBar.value = force
	


func _on_StartArea_body_entered(body):
	
	started = true
	


func _on_EndArea_body_entered(body):
	
	LevelManager.next_level()
	


func _on_RestartTimer_timeout():
	
	LevelManager.restart_level("Le câble a cassé, car trop de force a été exercé sur lui.")
	
	pass # Replace with function body.
