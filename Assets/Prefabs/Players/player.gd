extends CharacterBody2D

const MAX_SPEED = 100
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0
@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar


func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(check_deal_damage)
	health_component.health_changed.connect(on_health_changed)
	on_health_changed()


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	var target_velocity = MAX_SPEED * direction
	velocity = velocity.lerp(target_velocity, 1-exp(-delta*ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func check_deal_damage():
	if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
		return
	
	health_component.damage(1)
	damage_interval_timer.start()
	print(health_component.current_health)


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1

func on_health_changed():
	health_bar.value = health_component.get_health_percent()
