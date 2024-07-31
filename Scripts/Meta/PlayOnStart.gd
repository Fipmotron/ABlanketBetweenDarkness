extends AnimationPlayer

func _ready():
	play("Title")

func _Level_One():
	get_tree().change_scene_to_file("res://Scenes/LevelOne.tscn")
