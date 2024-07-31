extends DirectionalLight2D

var Dim := false

func _ready():
	# -- Setup -- #
	SignalManager.connect("Lights_On", Callable(self, "_On"))
	SignalManager.connect("Lights_Off", Callable(self, "_Off"))
	
	SignalManager.connect("Dim_Lights", Callable(self, "_Dim"))

func _On():
	if not Dim:
		energy = 0.5
	else:
		energy = 0.9
	
	print(Dim)

func _Off():
	energy = 0.975

func _Dim():
	Dim = true
