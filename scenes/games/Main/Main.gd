extends Node



export(Resource) var levels_config


var current_level_index := 0


onready var root := $Level
onready var countdown := $CanvasLayer/Control/Countdown


var loading := false


var loader : ResourceInteractiveLoader

var level_resource

var next_level = null


var hours := 0
var minutes := 0
var seconds := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_level(current_level_index)
	
	LevelManager.connect("next_level_called", self, "go_to_next_level")
	LevelManager.connect("restart_level_called", self, "restart_level")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if loader:
		var result = loader.poll()
		if result == ERR_FILE_EOF:
			level_resource = loader.get_resource()
			next_level = level_resource.instance()
			loader = null
			$StartTimer.start()
		
	


func _unhandled_input(event):
	
	if Input.is_action_just_pressed("next_level"):
		
		go_to_next_level()
		


func go_to_next_level():
	
	if loading:
		return
	
	current_level_index = current_level_index +1
	load_level(current_level_index)
	
	$AnimationPlayer.play("fadeIn")
	
	# save time
	hours = countdown.hours
	minutes = countdown.minutes
	seconds = countdown.seconds
	


func restart_level(cause):
	
	$AnimationPlayer.play("fadeIn")
	
	if cause != "":
		$CanvasLayer/Cause.text = cause
		$CanvasLayer/Cause.visible = true
	
	next_level = level_resource.instance()
	#load_level(current_level_index)
	
	$StartTimer.start()
	
	# restore time
	countdown.hours = hours
	countdown.minutes = minutes
	countdown.seconds = seconds


func load_level(index : int):
	if levels_config and index >= 0:
		var level_paths : Array = levels_config.level_paths
		
		if index < level_paths.size():
			var level_path : String = level_paths[index]
			
			loader = ResourceLoader.load_interactive("res://%s" % level_path)
			
			print("loader created", loader)
			
			#var next_level_resource = load("res://%s" % level_path)
			#next_level = next_level_resource.instance()
			
			
			loading = true
			
		else:
			push_error("Invalid index %d to load level" % index)
		
	else:
		push_error("Invalid levels config")
	


func start_level_loaded():
	
	if next_level:
		
		_clean_scene()
		
		root.add_child(next_level)
		next_level = null
		
		$AnimationPlayer.play("fadeOut")
		$CanvasLayer/Cause.visible = false
		
		loading = false


func _clean_scene():
	
	for child in root.get_children():
		child.queue_free()
	
