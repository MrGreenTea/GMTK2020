extends Node2D

onready var sprite = $Sprite

func _ready():
	pass

func play():
	print("Play called")
	#$Tween.interpolate_property(sprite, "scale", Vector2(0,0), Vector2(1,1), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	#$Tween.start()
	$AnimationPlayer.play("player_lost")
	
func _physics_process(delta):
	#play()
	pass
