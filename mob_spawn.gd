extends Node

@export var mob_scene: PackedScene

const _speed = 200
const max = 50
var times = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$tower/CollisionShape2D.get
	
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
