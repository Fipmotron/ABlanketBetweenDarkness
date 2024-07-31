extends Area2D

func _Transition():
	var a = get_tree().create_tween()
	var b = get_tree().get_first_node_in_group("Fade")
	
	a.tween_property(b, "modulate:a", 255.0, 1.0)

func _Level_Three():
	get_tree().change_scene_to_file("res://Scenes/LevelThree.tscn")
