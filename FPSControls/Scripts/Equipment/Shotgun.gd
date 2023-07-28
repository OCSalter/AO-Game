extends Equipment

class_name Shotgun

const DAMAGE = 4
const RANGE = 1000

func fire(camera_position: Vector3, camera_transform: Transform3D) -> void:
	print("shotgun fire")
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(camera_position, camera_position - camera_transform.basis.z * RANGE)
	var collision = space.intersect_ray(query)
	if collision and collision.collider.has_method("bullet_hit"):
		collision.collider.bullet_hit(DAMAGE, camera_transform)
	
