extends Node2D
class_name BaseEmotion


signal emotion_resided
signal emotion_triggered


func trigger():
	emit_signal("emotion_triggered")
