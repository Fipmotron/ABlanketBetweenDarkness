extends Area2D

@export var Cutscene_Number := 0
@export var Keep_Lights_Off := false

@export var Only_In_Area := false

var In_Area := false
var Lights_On := true
var In_Cutscene := false

func _ready():
	SignalManager.connect("Lights_On", Callable(self, "_Lights_On"))
	SignalManager.connect("Lights_Off", Callable(self, "_Lights_Off"))

func _physics_process(_delta):
	if Only_In_Area:
		if In_Area and not In_Cutscene:
			if Keep_Lights_Off:
				SignalManager.emit_signal("Dim_Lights")
			
			SignalManager.emit_signal("Cutscene_Starter", Cutscene_Number)
			In_Cutscene = true
	elif not Lights_On and In_Area and not In_Cutscene:
		if Keep_Lights_Off:
			SignalManager.emit_signal("Dim_Lights")
		
		SignalManager.emit_signal("Cutscene_Starter", Cutscene_Number)
		In_Cutscene = true

func _Lights_On():
	Lights_On = true

func _Lights_Off():
	Lights_On = false


func _Area_Entered(_area):
	In_Area = true

func _Area_Exited(_area):
	In_Area = false
