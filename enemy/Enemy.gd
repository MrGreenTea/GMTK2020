extends KinematicBody2D

export var SPEED = 128.0

var is_aggressive = false

var follow_target = null
var follow_target_last_position = null

const follow_tolerance = 10

func _ready():
	pass
	
func _physics_process(delta):
	$Eyesight.scan()
	if follow_target != null && is_aggressive:
		var run_to = follow_target - position
		if run_to.length() > follow_tolerance:
			var direction = (follow_target - position).normalized()
			move_and_slide(SPEED * direction)

func _on_Eyesight_player_noticed(node):
	follow_target = node.position

func _on_Eyesight_player_lost(node):
	pass

func _on_Property_destroyed():
	print("You destroyed my property!")
	is_aggressive = true

func _on_Lawn_intrusion(owner):
	if owner == self:
		print("You entered my laaaaawwwn!")
		is_aggressive = true

