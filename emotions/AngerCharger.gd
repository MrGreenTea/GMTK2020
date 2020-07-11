extends Area2D


var player: Player = null


func _physics_process(delta):
	if player != null:
		player.add_anger(delta * 5)


func _on_AreaCharger_body_entered(body):
	if body.name == "Player":
		player = body


func _on_AreaCharger_body_exited(body):
	if body.name == "Player":
		player = null
