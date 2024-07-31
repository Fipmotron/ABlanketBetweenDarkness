extends Sprite2D

var Repeat := true
var Scale := true

func _physics_process(_delta):
	if Repeat == true:
		_Move()
	if Scale:
		_Scale()

func _Scale():
	Scale = false
	
	var c = get_tree().create_tween()
	c.tween_property(self, "scale", Vector2(1.25, 1.25), 2.5)
	
	await c.finished
	
	var d = get_tree().create_tween()
	d.tween_property(self, "scale", Vector2(0.75, 0.75), 2.5)
	
	await d.finished
	
	Scale = true

func _Move():
	Repeat = false
	
	var a = get_tree().create_tween()
	
	a.tween_property(self, "rotation_degrees", 10.0, 5.0)
	
	await a.finished
	
	var b = get_tree().create_tween()
	
	b.tween_property(self, "rotation_degrees", -10.0, 5.0)
	
	await b.finished
	Repeat = true
