extends Node3D

@onready var empty_timer = $EmptyTimer

var meter: float
var current_meter: float
var recharge_rate: float


func setup(wait_time: float = 0.5, starting_meter: float = 100, starting_recharge_rate: float = 50):
	empty_timer.wait_time = wait_time
	meter = starting_meter
	current_meter = meter
	recharge_rate = starting_recharge_rate
	
func _physics_process(delta):
	if can_recharge():
		current_meter += recharge_rate * delta

func burn_meter(amount: float) -> bool:
	if current_meter <= 0:
		return false
	current_meter = current_meter - amount if current_meter > amount else 0
	if current_meter == 0:
		empty_timer.start()
	return true
	
func can_recharge() -> bool:
	return empty_timer.is_stopped()
