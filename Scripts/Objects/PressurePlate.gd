extends Area2D

func _Area_Entered(area):
	if area is PushableBlock:
		$Sprite2D.frame = 1
		get_parent()._Open()
		print(area.name)

func _Area_Exited(area):
	if area is PushableBlock:
		$Sprite2D.frame = 0
		get_parent()._Close()
