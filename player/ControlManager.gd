extends Node2D


onready var player: Player = get_parent()
onready var player_controler = $PlayerController
onready var active_controller = player_controler

var stress = 0

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	active_controller.control(player, delta)


func _on_Anger_emotion_resided():
	active_controller = player_controler
