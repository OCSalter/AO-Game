extends RigidBody3D

const BASE_BULLET_BOOST = 12

func bullet_hit(damage, bullet_global_trans):
	var direction: Vector3 =  bullet_global_trans.basis.z.normalized() * BASE_BULLET_BOOST
	
	apply_impulse((bullet_global_trans.origin - global_transform.origin).normalized() * -1, direction * damage * -1)
