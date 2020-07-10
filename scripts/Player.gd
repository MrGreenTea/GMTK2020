extends KinematicBody2D

export var SPEED = 128.0

func _process(delta):
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	self.move_and_collide(Vector2(x, y).normalized() * delta * SPEED)
