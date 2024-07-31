extends Control


func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://MasterSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://MusicSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()

func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://SFXSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()
