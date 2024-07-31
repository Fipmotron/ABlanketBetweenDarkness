extends CharacterBody2D

@export var Start_Open := false

@export var React_To_Lights := false
@export var Open_On_Dark := false

@onready var Anim = $AnimationPlayer/AnimationTree
var State

func _ready():
	State = Anim.get("parameters/playback")
	
	if Start_Open:
		_Open()
	elif not Start_Open:
		_Close()
	
	if React_To_Lights:
		SignalManager.connect("Lights_On", Callable(self, "_Lights_On"))
		SignalManager.connect("Lights_Off", Callable(self, "_Lights_Off"))

func _Open():
	var c = get_node("CollisionShape2D")
	var s = get_node("Sprite2D")
	
	State.travel("Open")
	$Open.play()
	
	c.set_deferred("disabled", true)
	s.set_deferred("visible", false)

func _Close():
	var c = get_node("CollisionShape2D")
	var s = get_node("Sprite2D")
	
	State.travel("Close")
	$Close.play()
	
	c.set_deferred("disabled", false)
	s.set_deferred("visible", true)

func _Lights_On():
	if Open_On_Dark:
		_Close()
	elif not Open_On_Dark:
		_Open()

func _Lights_Off():
	if Open_On_Dark:
		_Open()
	elif not Open_On_Dark:
		_Close()
