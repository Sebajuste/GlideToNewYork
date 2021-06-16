extends PathFollow


const CLOUD_SCENE := preload("res://scenes/objects/clouds/Cloud/Cloud.tscn")


export var speed := 10.0

export var noise : OpenSimplexNoise
export var threshold := 0.1


onready var root := self.owner


var cloud_popped := false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	self.offset += speed * delta
	
	if noise:
		var value := noise.get_noise_3dv(self.global_transform.origin)
		
		if not cloud_popped and value > threshold:
			
			var cloud := CLOUD_SCENE.instance()
			root.add_child(cloud)
			
			cloud.global_transform.origin = self.global_transform.origin
			
			if (randf() - 0.5) >= 0:
				cloud.global_transform.origin += $Pivot.global_transform.basis.x * rand_range(2.0, 100.0)
			else:
				cloud.global_transform.origin -= $Pivot.global_transform.basis.x * rand_range(2.0, 10.0)
			
			
			cloud.global_transform.origin -= $Pivot.global_transform.basis.z * 50
			
			cloud_popped = true
			
		elif cloud_popped and value < threshold:
			cloud_popped = false
			pass
		
	
	
	
