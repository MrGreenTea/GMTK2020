extends KinematicBody2D

export var SPEED = 128.0

var stress = 0
export(float, 0.1, 1000.0) var STRESS_PER_SECOND = 10.0
export(int, 1, 1000) var MAX_STRESS = 100

signal player_stressed

func _ready():
	$Stress.max_value = MAX_STRESS;

func _physics_process(delta):
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	self.move_and_slide(Vector2(x, y).normalized() * SPEED)
	stress += delta * STRESS_PER_SECOND
	$Stress.value = stress
	if stress >= MAX_STRESS:
		emit_signal("player_stressed")
		print("I'm stressed as fuck")
		stress = 0
