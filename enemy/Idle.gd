extends State

export(float) var idle_velocity = 25
export(float) var velocity_change_percent = 0.85

onready var last_velocity = Vector2(1,0)

func on_physics_process(target: Enemy, delta: float) -> void:
	var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized()
	var new_velocity = (last_velocity*(1-velocity_change_percent) + offset*velocity_change_percent).normalized() * idle_velocity
	$Tween.interpolate_method(target, "move_and_slide", Vector2.ZERO, new_velocity, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 1)
	$Tween.start()
