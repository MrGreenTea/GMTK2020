extends KinematicBody2D

export var SPEED = 128.0

var follow_target = null
var follow_target_last_position = null

func _ready():
	# get player node
	pass
	
func _physics_process(delta):
	$Eyesight.scan(rotation)
	if follow_target != null:
		var direction = (follow_target.position - position).normalized()
		move_and_slide(SPEED * direction)

#func look_for_target(target):
#	$Eyesight.cast_to = target
#	$Eyesight.fo

func _on_SenseVisual_body_entered(body):
	if body.name == "Player":
		follow_target = body

func _on_Eyesight_player_noticed(node):
	follow_target = node

func _on_Eyesight_player_lost(node):
	follow_target = null # Replace with function body.
