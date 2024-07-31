extends Area2D

# 0 For off,  1 For on
@export var State := 0
var P_Inside := false
var Interactable := true

func _ready():
	# -- Setup -- #
	SignalManager.connect("Reset_Level", Callable(self, "_Reset"))
	SignalManager.connect("New_Room", Callable(self, "_NRoom"))
	SignalManager.connect("Lights_On", Callable(self, "_State"))
	SignalManager.connect("Lights_Off", Callable(self, "_State"))

func _process(_delta):
	if P_Inside and Interactable:
		if Input.is_action_just_pressed("Interact"):
			match State:
				0:
					_Turn_On()
					State = 1
					print(State)
				1:
					_Turn_Off()
					State = 0
					print(State)

func _Body_Entered(body):
	# Player On Off Switching
	if body is Player:
		P_Inside = true

func _Body_Exited(body):
	# Player Left
	if body is Player:
		P_Inside = false

func _Turn_On():
	$AudioStreamPlayer2D.play()
	Interactable = false
	SignalManager.emit_signal("Lights_On")
	$Sprite2D.frame = 0
	await get_tree().create_timer(0.5).timeout
	Interactable = true

func _Turn_Off():
	$AudioStreamPlayer2D.play()
	Interactable = false
	SignalManager.emit_signal("Lights_Off")
	$Sprite2D.frame = 1
	await get_tree().create_timer(0.5).timeout
	Interactable = true

func _Reset():
	match State:
		0:
			_Turn_On()
			State = 1

func _State():
	match State:
		0:
			$AudioStreamPlayer2D.play()
			$Sprite2D.frame = 0
			State = 1
		1:
			$AudioStreamPlayer2D.play()
			$Sprite2D.frame = 1
			State = 0

func _NRoom(_a, _b):
	_Reset()

func _RLevel(_a):
	_Reset()

func _Animation_Destroy():
	Interactable = false
	$AnimationPlayer.play("Destroy")

func _Destroy():
	queue_free()
