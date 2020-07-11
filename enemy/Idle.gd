extends State

export(float) var idle_velocity = 50

func on_physics_process(target: Enemy, delta: float) -> void:
	var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * idle_velocity
	$Tween.interpolate_method(target, "move_and_slide", Vector2.ZERO, offset, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 0.3)
