extends State

export(float) var rage_velocity = 512

func _on_Tween_tween_all_completed():
	go_to("PlayerController")


func on_enter(target: Player):
	target.anger = 0
	target.fear *= 0.1
	target.get_node("AnimatedSprite").frame = 3
	for i in range(10):
		var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * rage_velocity
		$Tween.interpolate_method(target, "move", Vector2.ZERO, offset, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, i * 0.3)
	$Tween.start()

func on_physics_process(target: Player, delta: float) -> void:
	for o in target.get_node("DestructionArea").get_overlapping_bodies():
		o.queue_free()
	for p in target.get_node("PushArea").get_overlapping_bodies():
		var dir = p.position - target.position
		$Tween.interpolate_method(p, "move", dir, dir * 2, 0.2, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
