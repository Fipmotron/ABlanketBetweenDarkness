extends Area2D

@export var Max_Health := 0.0
var Health

var Ignore := false

func _ready():
	# -- Setup -- #
	Health = Max_Health

func _Area_Entered(area):
	if area is DamageComponent:
		for node in get_parent().get_children():
			if node == area:
				Ignore = true
			
		
		if not Ignore:
			Health -= area.Damage
			
			
			if Health <= 0.0:
				get_parent()._Death_Handler()
			else:
				get_parent()._Hit_Handler()
	Ignore = false
