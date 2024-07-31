extends CollisionShape2D

var Shape_Size := Vector2.ZERO

func _ready():
	Shape_Size = shape.size
	
	SignalManager.connect("Lights_Off", Callable(self, "_Off_Scale"))
	SignalManager.connect("Lights_On", Callable(self, "_On_Scale"))

func _Off_Scale():
	if get_parent().scale == Vector2.ZERO:
		set_deferred("disabled", true)
	else:
		set_deferred("disabled", false)
		shape.size = Shape_Size

func _On_Scale():
	if get_parent().scale == Vector2.ZERO:
		set_deferred("disabled", true)
	else:
		set_deferred("disabled", false)
		shape.size = Shape_Size
