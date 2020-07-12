extends Area2D


func _on_CarDespawner_body_entered(body):
	body.queue_free()
