extends Node2D

@onready var play_button: Button = $CanvasLayer_UILayer/Button_NewGame
@onready var save_button: Button = $CanvasLayer_UILayer/Button_SaveButton
@onready var load_button: Button = $CanvasLayer_UILayer/Button_LoadButton
@onready var quit_button: Button = $CanvasLayer_UILayer/Button_QuitButton
@onready var settings_button: Button = $CanvasLayer_UILayer/Button_Settings

func _ready():
	# Применим сохранённые настройки
	_apply_saved_settings()

	# Загрузка локализации
	LocalizationManager.load("main_menu")

	play_button.text = LocalizationManager.t("main_menu", "play")
	save_button.text = LocalizationManager.t("main_menu", "save")
	load_button.text = LocalizationManager.t("main_menu", "load")
	quit_button.text = LocalizationManager.t("main_menu", "exit")
	settings_button.text = LocalizationManager.t("main_menu", "settings")

	play_button.pressed.connect(_on_new_game_pressed)
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	settings_button.pressed.connect(_on_settings_pressed)

func _apply_saved_settings():
	var config := ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var res = config.get_value("display", "resolution", Vector2i(1280, 720))
		var lang = config.get_value("language", "lang", "ru")
		var fullscreen = config.get_value("display", "fullscreen", false)

		DisplayServer.window_set_size(res)
		
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		LocalizationManager.set_language(lang)

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/node_2d_video_stream_player_cutscene.tscn")

func _on_save_pressed():
	print("Игра сохранена!")
	# логика сохранения

func _on_load_pressed():
	print("Игра загружена!")
	# логика загрузки

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/node_2d_settings.tscn")
