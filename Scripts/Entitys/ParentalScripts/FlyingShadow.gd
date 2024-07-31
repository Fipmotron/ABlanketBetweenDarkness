extends CharacterBody2D

@export var Chase_Speed := 2.0
@export var Slow_Speed := 0.5
var Speed := 0.0

@onready var NavigationAgent: NavigationAgent2D = $NavigationAgent2D

var Start_Position

func _ready():
	SignalManager.connect("Reset_Level", Callable(self, "_Death_Handler"))
	SignalManager.connect("Lights_On", Callable(self, "_Death_Handler"))

func _physics_process(_delta):
	global_position = global_position.move_toward(NavigationAgent.get_next_path_position(), Speed)


func _New_Point(Point_Position : Vector2):
	NavigationAgent.target_position = Point_Position

func _Death_Handler():
	queue_free()
