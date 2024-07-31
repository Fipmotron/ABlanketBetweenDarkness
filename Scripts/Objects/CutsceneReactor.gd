extends AnimationPlayer

@export var Cutscene_Number := 0

func _ready():
	SignalManager.connect("Cutscene_Starter", Callable(self, "_Play"))

func _Play(Num):
	if Cutscene_Number == Num:
		active = true
		play("Cutscene")
