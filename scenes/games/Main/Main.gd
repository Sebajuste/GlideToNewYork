extends Node



export(Resource) var levels_config


var current_level_index := 0


onready var root := $Level



# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_level(current_level_index)
	
	LevelManager.connect("next_level_called", self, "go_to_next_level")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _unhandled_input(event):
	
	if Input.is_action_just_pressed("next_level"):
		
		go_to_next_level()
		
	


func go_to_next_level():
	current_level_index = current_level_index +1
	load_level(current_level_index)
	pass


func load_level(index : int):
	if levels_config and index >= 0:
		var level_paths : Array = levels_config.level_paths
		
		if index < level_paths.size():
			var level_path : String = level_paths[index]
			
			var next_level_resource = load("res://%s" % level_path)
			var next_level = next_level_resource.instance()
			
			for child in root.get_children():
				child.queue_free()
			
			root.add_child(next_level)
			
		else:
			push_error("Invalid index %d to load level" % index)
		
	else:
		push_error("Invalid levels config")
	
	
	pass


func reset_level():
	
	load_level(current_level_index)
	
	pass
