extends Node

var _power
var _target
var _tower_position
const _speed = 500

func set_power(power):
	_power = power

func set_target(mob):
	_target = mob

func set_tower_position(tower_position):
	_tower_position = tower_position

# Called when the node enters the scene tree for the first time.
func _ready():
	$BulletPath.curve.add_point(_tower_position)
	$BulletPath.curve.add_point(_target.get_parent().position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$BulletPath.curve.clear_points()
	if (!!_target):
		$BulletPath.curve.add_point(_tower_position)
		$BulletPath.curve.add_point(_target.get_parent().position)
	
		var newProgress = $BulletPath/PathFollow.get_progress() + _speed * delta
		var pathLength = $BulletPath.curve.get_baked_length()
		if (newProgress >= pathLength):
			_target.hp -= _power
			queue_free()
		else :
			$BulletPath/PathFollow.set_progress(newProgress)
	else:
		queue_free()
