extends Node2D

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	pass

func play():
	pass
	#$Tween.interpolate_method(sprite, "size", last_velocity, new_velocity, rand_range(0.85, 1.15), Tween.TRANS_BACK, Tween.EASE_IN_OUT)
