extends ColorRect

func _ready():
	var a = get_tree().create_tween()
	a.tween_property(self, "modulate:a", 0.0, 1.0)
	await a.finished
