extends CharacterBody2D

@export_subgroup("Position")
@export var Change_Position := false
@export var New_Position := Vector2.ZERO
var Start_Position

@export_subgroup("Rotation")
@export var Change_Rotation := false
@export var New_Rotation := 0.0
var Start_Rotation

@export_subgroup("Scale")
@export var Change_Scale := false
@export var New_Scale := Vector2(1, 1)
var Start_Scale

func _ready():
	# -- Setup -- #
	Start_Position = global_position
	Start_Rotation = rotation_degrees
	Start_Scale = scale
	
	SignalManager.connect("Lights_On", Callable(self, "_On"))
	SignalManager.connect("Lights_Off", Callable(self, "_Off"))

func _On():
	$Magic.play()
	
	# Transform Objects
	if Change_Position:
		var pos_tween = get_tree().create_tween()
		pos_tween.tween_property(self, "global_position", Start_Position, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	if Change_Rotation:
		var rot_tween = get_tree().create_tween()
		rot_tween.tween_property(self, "rotation_degrees", Start_Rotation, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	if Change_Scale:
		
		var sca_tween = get_tree().create_tween()
		sca_tween.tween_property(self, "scale", Start_Scale, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
		await sca_tween.finished

func _Off():
	$Magic.play()
	
	# Transform Objects
	if Change_Position:
		var pos_tween = get_tree().create_tween()
		pos_tween.tween_property(self, "global_position", New_Position, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	if Change_Rotation:
		var rot_tween = get_tree().create_tween()
		rot_tween.tween_property(self, "rotation_degrees", New_Rotation, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	if Change_Scale:
		
		var sca_tween = get_tree().create_tween()
		sca_tween.tween_property(self, "scale", New_Scale, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
		await sca_tween.finished


func _Reset():
	global_position = Start_Position
	rotation_degrees = Start_Rotation
	global_scale = Start_Scale
