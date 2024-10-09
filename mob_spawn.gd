extends Node

@export var mob_scene: PackedScene
@export var new_tower_scene: PackedScene
@export var tower_scene: PackedScene

const _speed = 200
const max = 50
var times = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	for mob in $MobPath.get_children():
		var newProgress = mob.get_progress() + _speed * delta
		var pathLength = $MobPath.get_curve().get_baked_length()
		if (newProgress >= pathLength) :
			$MobPath.remove_child(mob)
		else :
			mob.set_progress(newProgress)


func _on_mob_timer_timeout():
	times += 1
	if times >= max:
		$MobTimer.stop()
	var pathFollow = PathFollow2D.new()
	var mob = mob_scene.instantiate()
	pathFollow.add_child(mob)
	$MobPath.add_child(pathFollow)


func _on_new_tower_pressed():
	var new_tower = new_tower_scene.instantiate()
	new_tower.place_tower.connect(_on_place_tower)
	self.add_child(new_tower)
	
func _on_place_tower(position):
	var tower = tower_scene.instantiate()
	tower.position = position
	self.add_child(tower)
