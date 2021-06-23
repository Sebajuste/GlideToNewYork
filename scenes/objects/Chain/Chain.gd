tool
extends Spatial



export(NodePath) var from_path
export(NodePath) var to_path
export var split := 5


onready var from : Spatial = get_node(from_path)
onready var to : Spatial = get_node(to_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	yield(owner, "ready")
	create_chain()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func delete_chain():
	
	for child in get_children():
		child.queue_free()
	
	pass


func create_chain():
	
	if not from or not to:
		return
	
	var delta_pos := to.global_transform.origin - from.global_transform.origin
	var to_dir := delta_pos.normalized()
	var total_length := delta_pos.length()
	
	var chain_length = total_length / split
	
	var chain_pos := from.global_transform.origin
	var current_object = from
	
	for index in range(0, split):
		
		var rigid := RigidBody.new()
		
		var mesh_instance := MeshInstance.new()
		mesh_instance.mesh = CapsuleMesh.new()
		mesh_instance.mesh.radius = 0.1
		mesh_instance.mesh.mid_height = chain_length
		rigid.add_child(mesh_instance)
		
		var collision_shape := CollisionShape.new()
		collision_shape.shape = CapsuleShape.new()
		collision_shape.shape.radius = 0.1
		collision_shape.shape.height = chain_length
		rigid.add_child(collision_shape)
		
		add_child(rigid)
		#rigid.global_transform.origin = chain_pos + to_dir / 2
		
		rigid.look_at_from_position(chain_pos + to_dir / 2, current_object.global_transform.origin, Vector3.UP)
		
		
		var chain := PinJoint.new()
		chain.set_node_a(current_object.get_path())
		chain.set_node_b(rigid.get_path())
		add_child(chain)
		chain.global_transform.origin = chain_pos
		
		var test := MeshInstance.new()
		test.mesh = SphereMesh.new()
		chain.add_child(test)
		
		current_object = rigid
		chain_pos += to_dir * chain_length
	
	var chain := PinJoint.new()
	add_child(chain)
	chain.set_node_a(current_object.get_path())
	chain.set_node_b(to.get_path())
	
	var test := MeshInstance.new()
	test.mesh = SphereMesh.new()
	chain.add_child(test)
	


func reset_chain():
	delete_chain()
	create_chain()
