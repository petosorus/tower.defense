extends Area2D

signal place_tower

@export var range = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = get_global_mouse_position()

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		place_tower.emit(event.position)
		queue_free()
