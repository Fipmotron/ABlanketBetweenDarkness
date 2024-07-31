extends Camera2D

@export var Rng_Strength := 30.0
@export var Shake_Fade := 5.0

var rng = RandomNumberGenerator.new()

var Shake_Strength := 0.0

@export var In_Cutscene := false
var Stop_Tracking := true

func _ready():
	# -- Set up -- #
	SignalManager.connect("New_Room", Callable(self, "_Bound_Setter"))
	SignalManager.connect("Cutscene_Starter", Callable(self, "_Cutscene"))

func _physics_process(_delta):
	if not In_Cutscene and Stop_Tracking:
		global_position = Vector2(get_tree().get_first_node_in_group("Player").global_position.x, get_tree().get_first_node_in_group("Player").global_position.y - 48)
	
	if Shake_Strength > 0:
		Shake_Strength = lerpf(Shake_Strength, 0, Shake_Fade * _delta)
		
		offset = _Random_Offset()

func _Bound_Setter(Bounds : Vector4, _Pos : Vector2):
	
	limit_left = -10000000
	limit_right = 10000000
	limit_top = -10000000
	limit_bottom = 10000000
	
	#var pos_tween = get_tree().create_tween()
	#pos_tween.tween_property(self, "global_position", Pos, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	# X-Left, Y-Top, Z-Right, W-Bottom
	var left_tween = get_tree().create_tween()
	var right_tween = get_tree().create_tween()
	var top_tween = get_tree().create_tween()
	var bottom_tween = get_tree().create_tween()
	
	left_tween.tween_property(self, "limit_left", int(Bounds.x), 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	top_tween.tween_property(self, "limit_top", int(Bounds.y), 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	right_tween.tween_property(self, "limit_right", int(Bounds.z), 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	bottom_tween.tween_property(self, "limit_bottom", int(Bounds.w), 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	


func _Cutscene(_Num):
	In_Cutscene = true

func _Apply_Shake():
	Shake_Strength = Rng_Strength

func _Random_Offset():
	return Vector2(rng.randf_range(-Shake_Strength, Shake_Strength), rng.randf_range(-Shake_Strength, Shake_Strength))
