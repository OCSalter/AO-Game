extends Equipment

class_name HML_Burst

const BURST_COUNT = 4
var fired = 0

@onready var fire_point = $FirePoint
@onready var cooldown_timer = $Cooldown_Timer
@onready var burst_timer = $Burst_Timer

var player_reference: PlayerBody = null

var projectile_obj = preload("res://Assets/Objects/hml_projectile.tscn")

func fire(_s: PlayerBody) -> void:
	if(cooldown_timer.is_stopped()):
		_spawn_projectile()
		burst_timer.start()
		cooldown_timer.start()

func alt_fire(_s: PlayerBody) -> void:
	pass
	
func _spawn_projectile():
	print(player_reference)
	var random_offset = Vector3(randf_range(-0.1,0.1),randf_range(-0.1,0.1), 0)
	var projectile_transform = fire_point.global_transform
	var projectile_instance = projectile_obj.instantiate()
	
	projectile_transform.origin += random_offset
	projectile_instance.global_transform = projectile_transform
	projectile_instance.add_collision_exception_with(player_reference)
	get_tree().get_root().add_child(projectile_instance)


func _on_burst_timer_timeout():
	if fired < BURST_COUNT:
		_spawn_projectile()
		fired += 1
		burst_timer.start()
	else:
		fired = 0
