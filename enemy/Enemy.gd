extends KinematicBody2D

export var SPEED = 128.0

var follow_target = null

func _ready():
	# get player node
	pass
	
func _process(delta):
	if follow_target != null:
		var direction = (follow_target.position - position).normalized()
		move_and_slide(SPEED * direction)


func _on_SenseVisual_body_entered(body):
	follow_target = body
