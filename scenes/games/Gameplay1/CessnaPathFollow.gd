extends PathFollow

signal end_of_path

func _ready():
	pass


func _process(delta):
	if unit_offset >= 1:
		emit_signal("end_of_path")
		pass
	pass


func _generate_curve(newOrigin : Vector3):
	get_parent()._generate_curve(newOrigin)
	set_unit_offset(0)
	pass
