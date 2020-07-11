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

func _on_Target_body_entered(body):
	print("YOU WIN")

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
	print("YOU WERE ARRESTED.")
