extends KinematicBody2D
class_name Player

export var SPEED = 128.0
var stress = 0
export var MAX_STRESS = 10.0
var anger = 0
var fear = 0

func _on_Target_body_entered(body):
	print("YOU WIN")
