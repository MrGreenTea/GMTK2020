tool
extends Area2D

export(NodePath) var my_owner

var player
var my_owner_node
var parent_node

signal lawn_intrusion(owner)

func _ready():
	# get player and owner nodes
	for node in get_tree().get_nodes_in_group("player"):
		player = node
	my_owner_node = get_node(my_owner)
	connect("lawn_intrusion", my_owner_node, "_on_Lawn_intrusion")
	emit_signal("lawn_intrusion")

func _on_EnemyLawn_body_entered(body):
	if body == player:
		emit_signal("lawn_intrusion", my_owner_node)

