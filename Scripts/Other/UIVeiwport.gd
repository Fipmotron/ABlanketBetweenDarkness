extends CanvasLayer

var Start_Timer := false
var _Timer := 1.5

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

func _physics_process(delta):
	if Start_Timer:
		_Timer -= delta
		
		if _Timer <= 0.0:
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
	if Input.is_action_just_pressed("Pause") and not get_tree().paused:
		$UI.visible = true
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		$UI.visible = false

func _Resume():
	get_tree().paused = false
	$UI.visible = false

func _Options():
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($UI/SelectionPanel, "position:y", 360, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($UI/OptionsPanel, "position:x", 0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

func _Exit():
	var a = get_tree().create_tween()
	
	Start_Timer = true
	
	$UI/ColorRect.visible = true
	a.tween_property($UI/ColorRect, "color:a", 1.0, 1.0)

func _Back():
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($UI/SelectionPanel, "position:y", 0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($UI/OptionsPanel, "position:x", -640, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

func _MaSlider(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://MasterSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()

func _MuSlider(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://MusicSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()

func _SFSlider(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	
	var save_file = FileAccess.open("user://SFXSound.save", FileAccess.WRITE)
	save_file.store_var(value)
	save_file.close()
