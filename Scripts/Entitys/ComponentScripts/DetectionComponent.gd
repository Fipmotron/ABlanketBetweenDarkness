extends Area2D

var Player_Detected := false
var Target

var Flypoints
var Nearest_Flypoint

func _ready():
	Flypoints = get_tree().get_nodes_in_group("FlyPoints")
	Nearest_Flypoint = Flypoints[0]

func _physics_process(_delta):
	if Player_Detected:
		get_parent().Speed = get_parent().Chase_Speed
		
		get_parent()._New_Point(Vector2(Target.global_position.x, Target.global_position.y - 16))
		
		$RayCast2D.target_position = Vector2(Target.global_position.x, Target.global_position.y - 16) - $RayCast2D.global_position
		
		if $RayCast2D.is_colliding():
			$RayCast2D.scale = Vector2.ZERO
			Player_Detected = false
	else:
		for i in Flypoints:
			if i.global_position.distance_to(global_position) < Nearest_Flypoint.global_position.distance_to(global_position):
				Nearest_Flypoint = i
		
		get_parent().Speed = get_parent().Slow_Speed
		
		if get_parent().NavigationAgent.is_navigation_finished():
			get_parent()._New_Point(Vector2(randf_range(Nearest_Flypoint.global_position.x - 32, Nearest_Flypoint.global_position.x + 32), randf_range(Nearest_Flypoint.global_position.y - 32, Nearest_Flypoint.global_position.y + 32)))

func _Body_Entered(body):
	Target = body
	
	$RayCast2D.scale = Vector2(1, 1)
	$RayCast2D.target_position = Vector2(Target.global_position.x, Target.global_position.y - 16) - $RayCast2D.global_position
	
	if $RayCast2D.is_colliding():
		Player_Detected = false
	else:
		Player_Detected = true

func _Body_Exited(_body):
	pass
