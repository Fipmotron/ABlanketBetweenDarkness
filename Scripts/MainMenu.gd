extends Control

var _Timer := 1.5
var Start_Timer := false
var _str = ""

func _ready():
	if FileAccess.file_exists("user://MasterSound.save"):
		var save = FileAccess.open("user://MasterSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(0, linear_to_db(value))
		$OptionsPanel/MasterVolumeLabel/HSlider.value = value
		save.close()
	
	if FileAccess.file_exists("user://MusicSound.save"):
		var save = FileAccess.open("user://MusicSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(1, linear_to_db(value))
		$OptionsPanel/MusicVolumeLabel/HSlider.value = value
		save.close()
	
	if FileAccess.file_exists("user://SFXSound.save"):
		var save = FileAccess.open("user://SFXSound.save", FileAccess.READ)
		var value = save.get_var()
		AudioServer.set_bus_volume_db(2, linear_to_db(value))
		$OptionsPanel/SFXVolumeLabel/HSlider.value = value
		save.close()

func _physics_process(delta):
	if Start_Timer:
		_Timer -= delta
		
		if _Timer <= 0.0:
			if _str == "str":
				get_tree().change_scene_to_file("res://Scenes/start_cutscene.tscn")
			elif _str == "LevelOne":
				get_tree().change_scene_to_file("res://Scenes/LevelOne.tscn")
			elif _str == "LevelThree":
				get_tree().change_scene_to_file("res://Scenes/LevelThree.tscn")

func _on_start_game_button_pressed():
	_pressed_SFX()
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", -180, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($StartGamePanel, "position:y", 0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	


func _on_start_story_button_pressed():
	_pressed_SFX()
	Start_Timer = true
	_str = "str"
	_Transition()


func _on_level_select_button_pressed():
	_pressed_SFX()
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", -540, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($LevelSelectionPanel, "position:x", -320, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)


func _on_options_button_pressed():
	_pressed_SFX()
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", -540, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($OptionsPanel, "position:x", -320, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)


func _on_quit_button_pressed():
	_pressed_SFX()
	get_tree().quit()


func _on_back_button_pressed():
	_pressed_SFX()
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	var c = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", -180, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($LevelSelectionPanel, "position:x", 320, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	c.tween_property($OptionsPanel, "position:x", -960, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

func _Transition():
	$TextureRect.visible = true
	var a = get_tree().create_tween()
	
	a.tween_property($TextureRect, "modulate:a", 1.0, 1.0)


func _on_your_room_button_pressed():
	_pressed_SFX()
	Start_Timer = true
	_str = "LevelOne"
	_Transition()

func _on_basement_button_pressed():
	_pressed_SFX()
	Start_Timer = true
	_str = "LevelThree"
	_Transition()

func _pressed_SFX():
	$AudioStreamPlayer2D.play()

func _on_CreditBack_button_pressed():
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", -180, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($CreditsPanel, "position:y", -540, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)


func _on_credits_button_pressed():
	var a = get_tree().create_tween()
	var b = get_tree().create_tween()
	
	a.tween_property($SelctionPanel, "position:y", 180, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	b.tween_property($CreditsPanel, "position:y", -180, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
