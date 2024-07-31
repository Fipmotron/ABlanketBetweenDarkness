extends Area2D

func _Entered(area):
	get_parent()._Update_Checkpoint(area.global_position)
