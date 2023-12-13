extends Equipment

class_name HML_Burst

const BURST_COUNT = 5
const RANGE = 2000

var fired = 0

@onready var fire_point = $FirePoint
@onready var cooldown_timer = $Cooldown_Timer
@onready var burst_timer = $Burst_Timer

var player_reference: PlayerBody = null

var target_reference: Node3D = null

var projectile_obj = preload("res://Assets/Objects/hml_projectile.tscn")

func fire(_s: PlayerBody) -> void:
	if(cooldown_timer.is_stopped()):
		launch()
		cooldown_timer.start()

func alt_fire(_s: PlayerBody) -> void:
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(_s.camera.global_position, _s.camera.global_position - _s.camera.global_transform.basis.z * RANGE)
	var collision = space.intersect_ray(query)
	if collision and collision.collider.has_method("bullet_hit"):
		target_reference = collision.collider
		print(target_reference)
	else: 
		target_reference = null
		
func launch() -> void:
	if fired < BURST_COUNT:
		_spawn_projectile()
		fired += 1
		burst_timer.start()
	else:
		fired = 0
	
func _spawn_projectile() -> void:
	var projectile_instance = projectile_obj.instantiate()
	projectile_instance.global_transform = fire_point.global_transform
	projectile_instance.target = target_reference
	projectile_instance.add_collision_exception_with(player_reference)
	get_tree().get_root().add_child(projectile_instance)

func _on_burst_timer_timeout() -> void:
	launch()
