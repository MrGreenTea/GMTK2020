extends KinematicBody2D
class_name Enemy

export var SPEED = 128.0

var is_aggressive = false

var follow_target = null
var follow_target_last_position = null

const follow_tolerance = 10
onready var frames = $EnemyFrame

func _ready():
	pass

func _on_Property_destroyed():
	print("You destroyed my property!")
	is_aggressive = true
	$EnemyController.go_to("Chasing")

func _on_Lawn_intrusion(owner):
	print("lawn itrusion checkW")
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


func move(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			frames.animation = "LEFT"
		else:
			frames.animation = "RIGHT"
	else:
		if direction.y > 0:
			frames.animation = "DOWN"
		else:
			frames.animation = "UP"
	
	if direction.length_squared() > 1:
		frames.playing = true
	
	return move_and_slide(direction)
