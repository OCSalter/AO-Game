extends CharacterBody3D

class_name HML_Projectile

const start_speed = 2
const end_speed = 300

const damage = 4

var speed = start_speed
@onready var delete_timer = $DeleteTimer
@onready var explode_timer = $ExplodeTimer

func _physics_process(delta):
	var _coll = move_and_collide(global_transform.basis.x * speed * delta)
	if _coll:
		
		set_physics_process(false)

func _on_explode_timer_timeout():
	delete_timer.start()


func _on_delete_timer_timeout():
	queue_free()


func _on_start_delay_timeout():
	speed = end_speed
