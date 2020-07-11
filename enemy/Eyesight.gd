extends RayCast2D

export(float) var eyesight_radius = 1000
export(float) var eyesight_angle_degrees = 180
export(float) var eyesight_angle_steps = 180

var visible_things = []
var eyesight_angle_radians = PI

signal entity_noticed(node)

func _ready():
	eyesight_angle_radians = deg2rad(eyesight_angle_degrees)

func scan(scan_angle):
	visible_things = []
	for angle in range(scan_angle-eyesight_angle_radians/2, scan_angle+eyesight_angle_radians/2, eyesight_angle_steps):
		set_cast_to(Vector2(0,1).rotated(angle) * eyesight_radius)
		force_raycast_update()
		var object = get_collider()
		# prints(Vector2(0,1).rotated(angle) * eyesight_radius, object)
		if object != null:
			visible_things.append(object)
	prints(scan_angle, visible_things)
