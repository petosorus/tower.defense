extends Area2D

@export var range = 100
@export var fire_rate = 1.5
@export var bullet_scene: PackedScene

var mobs_in_range = []
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.radius = range
	$Fire.set_wait_time(fire_rate)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire()

func _on_area_entered(area):
	mobs_in_range.append(area)
	mobs_in_range.sort_custom(compare_mobs_progress)

func _on_area_exited(area):
	mobs_in_range.erase(area)

func fire():
	if can_fire && mobs_in_range.size() > 0:
		can_fire = false
		$Fire.start()
		if mobs_in_range.size() > 0:
			var bullet = bullet_scene.instantiate()
			bullet.set_power(1)
			bullet.set_tower_position(self.position)
			bullet.set_target(mobs_in_range[0])
			self.get_parent().add_child(bullet)
			#mobs_in_range[0].hp -= 1

func compare_mobs_progress(a, b):
	return a.get_parent().get_progress_ratio() > b.get_parent().get_progress_ratio()

func _on_fire_timeout():
	can_fire = true

