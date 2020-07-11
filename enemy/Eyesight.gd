extends RayCast2D

export(float) var eyesight_radius = 1000
export(float) var eyesight_angle_degrees = 360
export(float) var eyesight_angle_steps = 180

var visible_things = []
var player

signal player_noticed(node)
signal player_lost(node)

func _ready():
	# find player
	for node in get_tree().get_nodes_in_group("player"):
		player = node
		prints("Found player", player)
	
	# add collision exception for tiles
	for node in get_tree().get_nodes_in_group("invisible_raycast"):
		add_exception(node)
		prints("Added exception", node)
	
func scan():
	look_at(player.position) # could be replaced with cast_to = ...
	var object = get_collider()
	if object != null && object.name == "Player":
		emit_signal("player_noticed", player)
	else:
		emit_signal("player_lost", player)

