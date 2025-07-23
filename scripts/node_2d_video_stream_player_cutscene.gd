extends Node2D

@onready var video_player = $Control/VideoStreamPlayer_Cutscene

func _ready():
	video_player.finished.connect(_on_video_finished)
	video_player.play()

func _on_video_finished():
	get_tree().change_scene_to_file("res://scenes/node_2d_create_player.tscn")
