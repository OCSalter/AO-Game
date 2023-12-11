extends Node3D
class_name DashNode

@onready var cooldown_timer = $CooldownTimer
@onready var dash_timer = $DashTimer
	
func setup(_cooldown_time: float, _dash_time: float):
	cooldown_timer.wait_time = _cooldown_time
	dash_timer.wait_time = _dash_time
	
func start_dash():
	cooldown_timer.start()
	dash_timer.start()

func dash_ready():
	return cooldown_timer.is_stopped()
	
func is_dashing():
	return !dash_timer.is_stopped()
