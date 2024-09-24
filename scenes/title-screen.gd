extends Control

onready var highscore := $main/highscore as Label

func _ready() -> void:
	highscore.text = "Highscore\n" + str(Global.highscore)

func _on_startbtn_pressed() ->void:
	if get_tree().change_scene("res://scenes/Main.tscn") != OK:
		print("algo deu errado")



func _on_quitbtn_pressed() -> void:
	get_tree().quit()
