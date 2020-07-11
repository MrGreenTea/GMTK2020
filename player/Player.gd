extends KinematicBody2D
class_name Player

export var SPEED = 128.0

func _on_Target_body_entered(body):
	print("YOU WIN")
