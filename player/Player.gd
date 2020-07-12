extends KinematicBody2D
class_name Player

export var SPEED = 192.0
var stress = 0
export var MAX_STRESS = 10.0
var anger = 0
var fear = 0
onready var _particles_material: ParticlesMaterial = $EmotionParticles.process_material
export(GradientTexture) var ANGER_GRADIENT
export(GradientTexture) var FEAR_GRADIENT

onready var frames = $PlayerFrame
var game_is_over = false

signal game_over(type)

func _on_Target_body_entered(body):
	if body == self:
		show_game_over("reached_target")

func add_anger(amount: float):
	anger += amount
	stress += amount
	_particles_material.color_ramp = ANGER_GRADIENT
	$EmotionParticles.show()
	$Timer.start()

func add_fear(amount: float):
	fear += amount
	stress += amount
	_particles_material.color_ramp = FEAR_GRADIENT
	$EmotionParticles.show()
	$Timer.start()

func _on_Timer_timeout():
	$EmotionParticles.hide()
	
func _on_Arrested():
	show_game_over("arrested")

func move(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			frames.animation = "LEFT"
		else:
			frames.animation = "RIGHT"
	else:
		if direction.y > 0:
			frames.animation = "DOWN"
		else:
			frames.animation = "UP"
	frames.playing = true
	return move_and_slide(direction)

func show_game_over(type):
	if not game_is_over:
		game_is_over = true
		emit_signal("game_over", type)
		get_node("/root/Node2D/Overlay/Transition").transition_out()
		yield(get_node("/root/Node2D/Overlay/Transition/AnimationPlayer"),"animation_finished") 
		get_node("/root/Node2D/Overlay/GameOver").visible = true
