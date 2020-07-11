extends Node2D

export(NodePath) var my_owner

var my_owner_node

func _ready():
	my_owner_node = get_node(my_owner)
	connect("tree_exiting", my_owner_node, "_on_Property_destroyed")
	
func is_destroyed():
	print("Is destroyed called!")

