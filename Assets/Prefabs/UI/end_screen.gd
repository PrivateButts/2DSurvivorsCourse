extends CanvasLayer


func _ready():
	get_tree().paused = true
	%RestartBtn.pressed.connect(on_restart_btn_pressed)
	%QuitBtn.pressed.connect(on_quit_btn_pressed)


func set_defeat():
	%Title.text = "Defeat"
	%Description.text = "You lost!"


func set_victory():
	%Title.text = "Defeat"
	%Description.text = "You lost!"


func on_restart_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/Main/main.tscn")
	
	
func on_quit_btn_pressed():
	get_tree().quit()
