extends CharacterBody3D

class_name HML_Projectile

const start_speed = 2
const end_speed = 40

var target: Node3D = null
var tracking = false

const damage = 2

var speed = self.start_speed
@onready var delete_timer = $DeleteTimer
@onready var explode_timer = $ExplodeTimer
@onready var face_target_y = $FaceTargetY
@onready var face_target_x = $FaceTargetY/FaceTargetX
@onready var dir_ref = $FaceTargetY/FaceTargetX/DirRef

func _physics_process(delta):
	var _coll = _hml_move_and_colide(delta)
	_check_collision(_coll)	

func _hml_move_and_colide(delta):
	if tracking and is_instance_valid(target):
		return 	_homing_move_and_colide(delta)
	else:
		return move_and_collide(-global_transform.basis.z * self.speed * delta)

func _homing_move_and_colide(delta):
	var target_pos = target.global_transform.origin
	face_target_y.face_point(target_pos, delta)
	face_target_x.face_point(target_pos, delta)
	var move_dir = -$FaceTargetY/FaceTargetX/DirRef.global_transform.basis.z
	return 	move_and_collide(move_dir * self.speed * delta)
	
func _check_collision(coll: KinematicCollision3D):
	if(coll):
		_check_damage_available(coll)
		set_physics_process(false)
		queue_free()
	
func _check_damage_available(coll: KinematicCollision3D) -> void:
	if coll.get_collider().has_method("bullet_hit"):
		coll.get_collider().bullet_hit(self.damage, self.global_transform)

func _on_start_delay_timeout() -> void:
	if target:
		tracking = true
	self.speed = self.end_speed

func _on_explode_timer_timeout() -> void:
	self.delete_timer.start()

func _on_delete_timer_timeout() -> void:
	queue_free()
