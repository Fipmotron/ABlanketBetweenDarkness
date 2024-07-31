extends CharacterBody2D

@export_subgroup("Run Varibles")
@export var SprintSpeed := 0.0
@export var WalkSpeed := 0.0

var Direction

@export_subgroup("Jump Varibles")
@export var Jump_Force := 0.0
@export var Gravity := 0.0

@export var Jump_Time := 0.0
var Start_JumpTime

@export var Jump_Buffer := 0.0
var Start_JumpBuffer

@export var Cyote_Time := 0.0
var Start_CyoteTime

var Is_Jumping := false

@export_subgroup("Block Varibles")
@export var Block_Time := 0.0
var Start_BlockTime
var Is_Blocking := false

var Health_Area
var Damage_Area

@export_subgroup("Death Varibles")
var Checkpoint_Position := Vector2.ZERO

@export_subgroup("Animation Varibles")
@export var In_Cutscene := false
var AnimTree
var StateMachine

var Is_Dead := false

func _ready():
	# -- Setup -- #
	Start_JumpTime = Jump_Time
	Start_JumpBuffer = Jump_Buffer
	Start_CyoteTime = Cyote_Time
	Start_BlockTime = Block_Time
	
	Health_Area = get_node_or_null("HealthComponent")
	Damage_Area = get_node_or_null("DamageComponent")
	
	AnimTree = get_node_or_null("AnimationPlayer/AnimationTree")
	
	if AnimTree != null:
		StateMachine = AnimTree.get("parameters/playback")
	
	Jump_Buffer = 0.0
	Block_Time = 0.0

func _physics_process(delta):
	if not In_Cutscene:
		# Get Input Direction
		Direction = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		
		# Players Alive
		if not Is_Dead:
			if Input.is_action_just_pressed("Reset"):
				_Death_Handler()
			
			# Get Block Input
			'''if Input.get_action_strength("Block") > 0.0 and not Health_Area == null and not Damage_Area == null and Block_Time <= 0.0 and is_on_floor():
				Is_Blocking = true
				Health_Area.monitoring = false
				Damage_Area.monitorable = true
			elif Input.is_action_just_released("Block") and not Health_Area == null and not Damage_Area == null and is_on_floor():
				Is_Blocking = false
				Health_Area.monitoring = true
				Damage_Area.monitorable = false
				Block_Time = Start_BlockTime
			
			# Block Cooldown
			if Block_Time > 0.0:
				Block_Time -= delta
			'''
			# Apply Movements
			if not Is_Blocking:
				
				velocity.x = Direction * WalkSpeed
				
				#  Slow down with pushing
				if is_on_wall():
					velocity.x = velocity.x / 2
				
				_Jump_Handler(delta)
				
				if not Is_Jumping:
					velocity.y = Gravity / 1.5
				
				move_and_slide()
		
		if AnimTree != null:
			_Animation_Handler()
	elif In_Cutscene:
		velocity = Vector2.ZERO

func _Jump_Handler(delta):
	# Get Jump Input
	if Input.is_action_just_pressed("Jump"):
		Jump_Buffer = Start_JumpBuffer
	
	if Jump_Buffer > 0.0:
		Jump_Buffer -= delta
	
	# Buffer Ground Input
	if not is_on_floor():
		Cyote_Time -= delta
	elif is_on_floor():
		Cyote_Time = Start_CyoteTime
		Is_Jumping = false
	
	# Start Jumping
	if Jump_Buffer > 0.0 and Cyote_Time > 0.0:
		$Jump.play()
		Jump_Time = Start_JumpTime
		Is_Jumping = true
	
	# Add Force
	if Jump_Time > 0.0:
		velocity.y = -Jump_Force
		Jump_Time -= delta
	
	# Start Going Down
	if Jump_Time <= 0.0:
		velocity.y = move_toward(velocity.y, Gravity, 50.0)

func _Hit_Handler():
	pass

func _Death_Handler():
	var h = get_node_or_null("Hit")
	
	if not h == null:
		$Hit.play()
	
	Is_Dead = true
	await get_tree().create_timer(1.0).timeout
	global_position = Checkpoint_Position
	SignalManager.emit_signal("Reset_Level")
	Is_Dead = false

func _Animation_Handler():
	
	if Is_Dead:
		StateMachine.travel("Death")
	elif Is_Blocking:
		StateMachine.travel("Block")
	elif velocity.y < 0.0:
		StateMachine.travel("Jump")
	elif not is_on_floor():
		StateMachine.travel("Fall")
	elif velocity.x != 0.0:
		StateMachine.travel("Walk")
	else:
		StateMachine.travel("Idle")
	
	if Direction > 0.0 and not Is_Dead:
		$Sprite2D.flip_h = false
	elif Direction < 0.0 and not Is_Dead:
		$Sprite2D.flip_h = true

func _Update_Checkpoint(Pos):
	Checkpoint_Position = Pos
