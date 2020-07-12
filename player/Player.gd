extends KinematicBody2D
class_name Player

export var SPEED = 192.0
var stress = 0
export var MAX_STRESS = 10.0
var anger = 0
var fear = 0

const PARTICLE_SPEED = 1000.0

var _anger_to_add = 0.0
var _fear_to_add = 0.0

onready var frames = $PlayerFrame
var game_is_over = false

signal game_over(type)

func _on_Target_body_entered(body):
	if body == self:
		show_game_over("reached_target")

func adjust_particles(node: Particles2D, amount: float, timer: Timer):
	if amount > 0:
		node.show()
		var color: Color = node.process_material.color_ramp.gradient.get_color(1)
		var prev = color.a
		color.a = clamp(amount, 0, 1)
		if "Fear" in node.name:
			print("prev:", prev, "now:", color.a)
		node.process_material.color_ramp.gradient.set_color(1, color)
		timer.start()

func _physics_process(delta):
	anger += _anger_to_add
	adjust_particles($AngerParticles, _anger_to_add, $AngerTimer)
	_anger_to_add = 0
	
	fear += _fear_to_add
	adjust_particles($FearParticles, _fear_to_add, $FearTimer)
	_fear_to_add = 0


func add_anger(amount: float):
	_anger_to_add += amount
	stress += amount

func add_fear(amount: float):
	_fear_to_add += amount
	stress += amount
	
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


func _on_FearTimer_timeout():
	$FearParticles.hide()


func _on_AngerTimer_timeout():
	$AngerParticles.hide()
