extends Node3D

@onready var cooldown_timer = $CooldownTimer
@onready var dash_timer = $DashTimer

func setup(tc: float, td: float):
	cooldown_timer.wait_time = tc
	dash_timer.wait_time = td


func start_dash():
	cooldown_timer.start()
	dash_timer.start()

func dash_ready():
	return cooldown_timer.is_stopped()
	
func is_dashing():
	return !dash_timer.is_stopped()
