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

func _physics_process(delta):
	$EmotionParticles.hide()

func add_anger(amount: float):
	anger += amount
	stress += amount
	$EmotionParticles.show()
	_particles_material.color_ramp = ANGER_GRADIENT

func add_fear(amount: float):
	fear += amount
	stress += amount
	$EmotionParticles.show()
	_particles_material.color_ramp = FEAR_GRADIENT
