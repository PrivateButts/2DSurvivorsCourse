extends Node

@export var end_screen_scene: PackedScene


func _ready():
	%Player.health_component.died.connect(on_player_died)
	%Player.health_component.died.connect(on_player_died)


func on_player_died():
	var end_screen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.set_defeat()


func on_player_victory():
	var end_screen = end_screen_scene.instantiate()
	add_child(end_screen)
	end_screen.set_victory()
