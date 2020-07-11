extends State


func _on_Tween_tween_all_completed():
	go_to("PlayerController")


func on_enter(target: Player):
	target.get_node("AnimatedSprite").frame = 3
	for i in range(10):
		var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * 512		
		$Tween.interpolate_method(target, "move_and_slide", Vector2.ZERO, offset, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, i * 0.3)
	$Tween.start()
	for o in target.get_node("Area2D").get_overlapping_bodies():
		o.queue_free()
