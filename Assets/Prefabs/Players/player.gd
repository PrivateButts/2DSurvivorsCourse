extends CharacterBody2D

const MAX_SPEED = 100
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0
@onready var damage_interval_timer = $DamageIntervalTimer


func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(check_deal_damage)


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
	
	$HealthComponent.damage(1)
	damage_interval_timer.start()
	print($HealthComponent.current_health)


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()

func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1
