extends KinematicBody2D
class_name Enemy

export var SPEED = 128.0

var is_aggressive = false

var follow_target = null
var follow_target_last_position = null

const follow_tolerance = 10

func _ready():
	pass

func _on_Property_destroyed():
	print("You destroyed my property!")
	is_aggressive = true
	$EnemyController.go_to("Chasing")

func _on_Lawn_intrusion(owner):
	if owner == self:
		print("You entered my laaaaawwwn!")
		is_aggressive = true
		$EnemyController.go_to("Chasing")

func _on_Eyesight_player_noticed(node):
	follow_target = node.position
	if is_aggressive:
		$EnemyController.go_to("Chasing")

func _on_Eyesight_player_lost(node):
	$EnemyController.go_to("Idle")
