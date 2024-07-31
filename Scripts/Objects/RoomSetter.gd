extends Area2D

@export var Bounds = Vector4(0, 0, 0, 0)
@export var New_Position := Vector2.ZERO

func _Body_Entered(_body):
	SignalManager.emit_signal("New_Room", Bounds, $CollisionShape2D.global_position)
