extends Node2D

@export var Enemy_Type := ""

@export var Number_Of_Enemies := 0
var Enemy_Array := []

@export var Spawn_Time := 0.0
@export var Respawn_Time := 0.0
var Start_SpawnTime

var Can_Spawn := false

func _ready():
	Start_SpawnTime = Spawn_Time
	
	SignalManager.connect("Lights_Off", Callable(self, "_Lights_Off"))
	SignalManager.connect("Lights_On", Callable(self, "_Lights_On"))

func _physics_process(delta):
	if Spawn_Time > 0.0:
		Spawn_Time -= delta
	
	if Enemy_Array.size() != 0:
		for i in Enemy_Array:
			if i == null:
				Enemy_Array.erase(i)
				Spawn_Time = Respawn_Time
				print(Spawn_Time)
	
	if Enemy_Array.size() < Number_Of_Enemies and Can_Spawn and not Spawn_Time > 0.0:
		_Spawn()

func _Spawn():
	print(Enemy_Type)
	var Entity = load(str(Enemy_Type)).instantiate()
	print(get_tree().get_root().get_child(get_tree().get_root().get_children().size() - 1))
	get_tree().get_root().add_child(Entity)
	Entity.global_position = global_position
	Enemy_Array.append(Entity)
	Spawn_Time = Start_SpawnTime

func _Lights_On():
	Can_Spawn = false

func _Lights_Off():
	Can_Spawn = true
