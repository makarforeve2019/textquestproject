extends Node2D

@onready var race_select = $CanvasLayer_UILayer/StatsContainer/OptionButton
@onready var stats_container = $CanvasLayer_UILayer/StatsContainer
@onready var strength_label = $CanvasLayer_UILayer/StatsContainer/Label_StrengthLabel
@onready var reaction_label = $CanvasLayer_UILayer/StatsContainer/Label_ReactionLabel
@onready var intellect_label = $CanvasLayer_UILayer/StatsContainer/Label_IntellectLabel
@onready var empathy_label = $CanvasLayer_UILayer/StatsContainer/Label_EmpathyLabel
@onready var description_label = $CanvasLayer_UILayer/StatsContainer/Label_DescriptionLabel

@onready var next_button: Button = $CanvasLayer_UILayer/Button_Next

func _ready():
	LocalizationManager.load("create_player")
	LocalizationManager.load("shared")  # важно для рас
	
	next_button.pressed.connect(_on_next_button)

	# Загрузка рас и их отображаемых названий
	var dir = DirAccess.open("res://races/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				var race_folder = file_name
				var json_path = "res://races/" + race_folder + "/stats.json"
				if FileAccess.file_exists(json_path):
					var stats = _load_stats(json_path)
					var name_key = stats.get("name", race_folder)
					var translated_name = LocalizationManager.translate_stat_value(name_key)
					race_select.add_item(translated_name)
			file_name = dir.get_next()
		dir.list_dir_end()

	race_select.item_selected.connect(_on_race_selected)

	if race_select.get_item_count() > 0:
		_on_race_selected(0)

func _on_next_button():
	get_tree().change_scene_to_file("res://scenes/node_2d_origin_select.tscn")


func _on_race_selected(index: int) -> void:
	var display_name = race_select.get_item_text(index)
	_update_stats_by_display_name(display_name)

func _update_stats_by_display_name(display_name: String) -> void:
	var race_folders = {}
	var dir = DirAccess.open("res://races/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				var race_folder = file_name
				var json_path = "res://races/" + race_folder + "/stats.json"
				if FileAccess.file_exists(json_path):
					var stats = _load_stats(json_path)
					var name_key = stats.get("name", race_folder)
					var translated_name = LocalizationManager.translate_stat_value(name_key)
					race_folders[translated_name] = race_folder
			file_name = dir.get_next()
		dir.list_dir_end()

	var folder_name = race_folders.get(display_name, null)
	if folder_name:
		var path = "res://races/" + folder_name + "/stats.json"
		var stats = _load_stats(path)
		_display_stats(stats)

func _load_stats(path: String) -> Dictionary:
	var result: Dictionary = {}
	if FileAccess.file_exists(path):
		var content := FileAccess.get_file_as_string(path)
		var json := JSON.new()
		if json.parse(content) == OK:
			result = json.data
	return result

func _display_stats(stats: Dictionary) -> void:
	strength_label.text = LocalizationManager.t("create_player", "strength") + ": " + str(stats.get("strength", 0))
	reaction_label.text = LocalizationManager.t("create_player", "reaction") + ": " + str(stats.get("reaction", 0))
	intellect_label.text = LocalizationManager.t("create_player", "intellect") + ": " + str(stats.get("intellect", 0))
	empathy_label.text = LocalizationManager.t("create_player", "empathy") + ": " + str(stats.get("empathy", 0))

	var raw_desc = stats.get("description", "unknown_description_key")
	var translated_desc = LocalizationManager.translate_stat_value(raw_desc)
	description_label.text = LocalizationManager.t("create_player", "description") + ": " + translated_desc
