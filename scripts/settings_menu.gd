extends Node2D

@onready var resolution_selector: OptionButton = $CanvasLayer_UILayer/VBoxContainer/ResolutionSelector
@onready var language_selector: OptionButton = $CanvasLayer_UILayer/VBoxContainer/LanguageSelector
@onready var fullscreen_toggle: CheckBox = $CanvasLayer_UILayer/VBoxContainer/CheckBox_FullscreenToggle
@onready var save_button: Button = $CanvasLayer_UILayer/VBoxContainer/SaveButton
@onready var back_button: Button = $CanvasLayer_UILayer/VBoxContainer/BackButton

var resolutions = [
	{"label": "1280x720", "size": Vector2i(1280, 720)},
	{"label": "1600x900", "size": Vector2i(1600, 900)},
	{"label": "1920x1080", "size": Vector2i(1920, 1080)}
]

var languages = ["ru", "en"]

func _ready():
	LocalizationManager.load("settings")

	# Заполнение разрешений
	resolution_selector.clear()
	for res in resolutions:
		resolution_selector.add_item(res.label)

	# Язык
	language_selector.clear()
	language_selector.add_item("Русский")
	language_selector.add_item("English")

	# Загрузка конфигурации
	var config := ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var saved_res = config.get_value("display", "resolution", Vector2i(1280, 720))
		var saved_lang = config.get_value("language", "lang", "ru")
		var is_fullscreen = config.get_value("display", "fullscreen", false)

		for i in range(resolutions.size()):
			if resolutions[i].size == saved_res:
				resolution_selector.selected = i
				break

		language_selector.selected = 0 if saved_lang == "ru" else 1
		fullscreen_toggle.button_pressed = is_fullscreen
		LocalizationManager.set_language(saved_lang)
	else:
		resolution_selector.selected = 0
		language_selector.selected = 0
		fullscreen_toggle.button_pressed = false

	save_button.text = LocalizationManager.t("settings", "save")
	back_button.text = LocalizationManager.t("settings", "back")

	save_button.pressed.connect(_on_save_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_save_pressed():
	var selected_res = resolutions[resolution_selector.selected].size
	var lang = "ru" if language_selector.selected == 0 else "en"
	var fullscreen = fullscreen_toggle.button_pressed

	# Применить разрешение
	DisplayServer.window_set_size(selected_res)
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	LocalizationManager.set_language(lang)

	# Сохранить
	var config := ConfigFile.new()
	config.set_value("display", "resolution", selected_res)
	config.set_value("display", "fullscreen", fullscreen)
	config.set_value("language", "lang", lang)
	config.save("user://settings.cfg")
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
