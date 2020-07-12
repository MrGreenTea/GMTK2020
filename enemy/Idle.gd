extends State

export(float) var idle_velocity = 25

onready var last_velocity = Vector2(1,0)

func on_enter(target: Enemy) -> void:
	move(target)
	$Tween.start()

func move(target: Enemy) -> void:
	var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized()
	var new_velocity = offset * idle_velocity * rand_range(0.8, 1.2)
	last_velocity = new_velocity
	$Tween.interpolate_method(target, "move", last_velocity, new_velocity, rand_range(0.85, 1.15), Tween.TRANS_BACK, Tween.EASE_IN_OUT)


func _on_Tween_tween_completed(object, key):
	move(self.target)
	$Tween.start()
