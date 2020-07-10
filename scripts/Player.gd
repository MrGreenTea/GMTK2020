extends KinematicBody2D

func _process(delta):
	var x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	self.translate(Vector2(x, y).normalized())
