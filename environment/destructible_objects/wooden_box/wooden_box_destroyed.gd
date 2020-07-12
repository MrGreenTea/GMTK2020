extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("explode")
