extends Area2D

@export var Gravity := 0.0

var Is_Inside = false
var Pusher

var Tester

func _ready():
	Tester = get_node_or_null("CollisionShape2D")


func _physics_process(_delta):
	if not Tester == null:
		if Is_Inside:
			get_parent().velocity.x = Pusher.velocity.x / 2
		elif not Is_Inside:
			get_parent().velocity.x = 0.0
		
		get_parent().velocity.y = Gravity
		get_parent().move_and_slide()

func _Body_Entered(body):
	if body is CharacterBody2D:
		Pusher = body
		Is_Inside = true

func _Body_Exited(body):
	if body is CharacterBody2D:
		Is_Inside = false
