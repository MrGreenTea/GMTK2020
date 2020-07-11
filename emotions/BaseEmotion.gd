extends Node2D
class_name BaseEmotion


signal emotion_resided
signal emotion_triggered


func rage_around(player: Node2D):
	for i in range(10):
		var offset = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * 512
		$Tween.interpolate_method(player, "move_and_slide", Vector2.ZERO, offset, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, i * 0.3)


func control():
	rage_around($"../..")
	$Tween.start()
	$"../emote_anger".show()
	for o in $"../Area2D".get_overlapping_bodies():
		o.queue_free()


func _on_Tween_tween_all_completed():
	$"..".emit_signal("emotion_resided")
	$"../emote_anger".hide()
