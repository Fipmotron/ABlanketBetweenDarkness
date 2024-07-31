extends Button

@export var Cutscene_Number := 2

func _on_pressed():
	SignalManager.emit_signal("Cutscene_Starter", Cutscene_Number)

func _Main():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
