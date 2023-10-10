extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
@onready var current_health = max_health


func damage(dmg: float):
	current_health = max(current_health-dmg, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()


func get_health_percent():
	return clamp(current_health/max_health, 0, 1)
