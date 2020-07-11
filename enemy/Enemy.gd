extends KinematicBody2D

export var SPEED = 128.0

var is_aggressive = false

var follow_target = null
var follow_target_last_position = null

const follow_tolerance = 10

func _ready():
	# get player node
	pass
	
func _physics_process(delta):
	$Eyesight.scan()
	if follow_target != null && is_aggressive:
		var run_to = follow_target - position
		if run_to.length() > follow_tolerance:
			var direction = (follow_target - position).normalized()
			move_and_slide(SPEED * direction)

func _on_SenseVisual_body_entered(body):
	if body.name == "Player":
		follow_target = body

func _on_Eyesight_player_noticed(node):
	follow_target = node.position

func _on_Eyesight_player_lost(node):
	pass

func _on_Wood_Crate_tree_exiting():
	is_aggressive = true
	print("You destroyed my crate!")
