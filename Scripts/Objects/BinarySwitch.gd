extends Area2D

@export var Gate_Parent := false
var Player_Inside := false
var Interactable := true

@export_group("Alchemy")
@export var Alch_Child := false

@export_subgroup("Position")
@export var Change_Position := false
@export var New_Position := Vector2.ZERO
var Old_Position

@export_subgroup("Rotation")
@export var Change_Rotation := false
@export var New_Rotation := 0.0
var Old_Rotation

@export_subgroup("Scale")
@export var Change_Scale := false
@export var New_Scale := Vector2(1, 1)
var Old_Scale

var state = 0

func _physics_process(_delta):
	if Input.is_action_just_pressed("Interact") and Interactable:
		if Player_Inside and state == 0:
			$AudioStreamPlayer2D.play()
			
			Interactable = false
			
			if Gate_Parent:
				get_parent()._Open()
			
			if Alch_Child:
				$Magic.play()
				
				if Change_Position:
					Old_Position = get_child(4).position
					var pos_tween = get_tree().create_tween()
					pos_tween.tween_property(get_child(4), "position", New_Position, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
				if Change_Rotation:
					Old_Rotation = get_child(4).rotation_degrees
					var rot_tween = get_tree().create_tween()
					rot_tween.tween_property(get_child(4), "rotation_degrees", New_Rotation, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
				if Change_Scale:
					Old_Scale = get_child(4).scale
					var sca_tween = get_tree().create_tween()
					sca_tween.tween_property(get_child(4), "scale", New_Scale, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
			
			state = 1
			
			await get_tree().create_timer(0.5).timeout
			Interactable = true
			
		elif Player_Inside and state == 1:
			$AudioStreamPlayer2D.play()
			
			Interactable = false
			
			if Gate_Parent:
				get_parent()._Close()
			
			if Alch_Child:
				$Magic.play()
				
				if Change_Position:
					var pos_tween = get_tree().create_tween()
					pos_tween.tween_property(get_child(4), "position", Old_Position, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
				if Change_Rotation:
					var rot_tween = get_parent().get_tree().create_tween()
					rot_tween.tween_property(get_child(4), "rotation_degrees", Old_Rotation, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
				if Change_Scale:
					var sca_tween = get_parent().get_tree().create_tween()
					sca_tween.tween_property(get_child(4), "scale", Old_Scale, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
			
			state = 0
			
			await get_tree().create_timer(0.5).timeout
			Interactable = true
	
	if state == 0:
		$Sprite2D.frame = 0
	elif state == 1:
		$Sprite2D.frame = 1

func _Area_Entered(_area):
	Player_Inside = true

func _Area_Exited(_area):
	Player_Inside = false
