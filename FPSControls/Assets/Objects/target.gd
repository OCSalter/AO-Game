extends RigidBody3D

const BASE_BULLET_BOOST = 12
const MAX_HP: float = 20

@onready var _health_node: HealthNode = $HealthNode

func _ready():
	_health_node.setup(MAX_HP)
	print(_health_node.damage(0))

func bullet_hit(damage, bullet_global_trans):
	var direction: Vector3 =  bullet_global_trans.basis.z.normalized() * BASE_BULLET_BOOST
	if _health_node:
		print(_health_node.damage(damage))
			
	apply_impulse((bullet_global_trans.origin - global_transform.origin).normalized() * -1, direction * damage * -1)
