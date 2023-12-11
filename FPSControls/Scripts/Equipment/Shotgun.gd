extends Equipment

class_name Shotgun

const DAMAGE = 4
const RANGE = 1000

func fire(_s: PlayerBody) -> void:
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(_s.camera.global_position, _s.camera.global_position - _s.camera.global_transform.basis.z * RANGE)
	var collision = space.intersect_ray(query)
	if collision and collision.collider.has_method("bullet_hit"):
		collision.collider.bullet_hit(DAMAGE, _s.camera.global_transform)
	
func alt_fire(_s: PlayerBody) -> void:
	pass
