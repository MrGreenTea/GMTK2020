extends RayCast2D

export(float) var eyesight_radius = 1000
export(float) var eyesight_angle_degrees = 360
export(float) var eyesight_angle_steps = 180

var visible_things = []
var eyesight_angle_radians = PI
var player

signal entity_noticed(node)
signal player_noticed(node)
signal player_lost(node)

func _ready():
	eyesight_angle_radians = deg2rad(eyesight_angle_degrees)
	# find player
	for node in get_tree().get_nodes_in_group("visible_people"):
		if node.name == "Player":
			player = node
			prints("Found player", player)
	
	# add collision exception for tiles
	for node in get_tree().get_nodes_in_group("invisible_raycast"):
		add_exception(node)
		prints("Added exception", node)
	
func scan(scan_angle):
	visible_things = []
	#for angle in range(scan_angle-eyesight_angle_radians/2, scan_angle+eyesight_angle_radians/2, eyesight_angle_steps):
	#var player_direction = 
	look_at(player.position)  #player.position# - position
	#set_cast_to(player.position)
	#set_cast_to(Vector2(0,1).rotated(rotation))
	# force_raycast_update()
	var object = get_collider()
	#prints(object)
	# prints(Vector2(0,1).rotated(angle) * eyesight_radius, object)
	if object != null && object.name == "Player":
		#visible_things.append(object)
		emit_signal("player_noticed", player)
	else:
		emit_signal("player_lost", player)
	#prints(scan_angle, visible_things)
