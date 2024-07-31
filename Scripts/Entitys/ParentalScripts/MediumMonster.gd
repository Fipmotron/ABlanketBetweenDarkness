extends CharacterBody2D

@export var Speed := 0.0
@export var Should_Move := false

var Start_Position

func _ready():
	Start_Position = global_position
	
	SignalManager.connect("Reset_Level", Callable(self, "_Reset"))

func _physics_process(_delta):
	if Should_Move:
		velocity.x  = Speed
		$DamageComponent/CollisionShape2D.disabled = false
		
		$GPUParticles2D.emitting = true
		
		$AnimationPlayer.play("Walk")
		
		move_and_slide()
	else:
		$DamageComponent/CollisionShape2D.disabled = true
		
		$GPUParticles2D.emitting = false

func _Reset():
	global_position = Start_Position
