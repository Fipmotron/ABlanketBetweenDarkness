extends Node2D

func _ready():
	if FileAccess.file_exists("user://MasterSound.save"):
		var save = FileAccess.open("user://MasterSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(0, linear_to_db(value))
		save.close()
	
	if FileAccess.file_exists("user://MusicSound.save"):
		var save = FileAccess.open("user://MusicSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(1, linear_to_db(value))
		save.close()
	
	if FileAccess.file_exists("user://SFXSound.save"):
		var save = FileAccess.open("user://SFXSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(2, linear_to_db(value))
		save.close()
