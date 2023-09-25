extends Node
class_name VialDropComponent

@export var vial_scene: PackedScene
@export var health_component: Node
@export_range(0,1) var drop_percentage: float = .5

func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	

func on_died():
	if randf() > drop_percentage:
		return

	if vial_scene == null:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	owner.add_sibling(vial_instance)
	vial_instance.global_position = spawn_position
	

