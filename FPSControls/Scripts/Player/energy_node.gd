extends Node3D
class_name EnergyNode

@onready var empty_timer = $EmptyTimer

var max_meter: float
var current_meter: float
var recharge_rate: float


func setup(_wait_time: float = 0.5, _max_meter: float = 100, _starting_recharge_rate: float = 5):
	empty_timer.wait_time = _wait_time
	max_meter = _max_meter
	current_meter = max_meter
	recharge_rate = _starting_recharge_rate
	
func _physics_process(delta):
	if can_recharge():
		current_meter += recharge_rate * delta

func try_then_burn(amount: float) -> bool:
	if current_meter <= 0:
		return false
	burn_meter(amount)
	return true
	
func burn_meter(amount: float):
	current_meter = current_meter - amount if current_meter > amount else 0.0
	if current_meter == 0:
		empty_timer.start()
	
func can_recharge() -> bool:
	return max_meter > current_meter and empty_timer.is_stopped()
