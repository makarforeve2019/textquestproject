extends Node2D

@onready var wealth_selector: OptionButton = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/OptionButton__wealth
@onready var parent_selector: OptionButton = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/OptionButton__parent
@onready var label_result: Label = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/Label_Result

@onready var label_caption: Label = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/Label_Caption
@onready var label_wealth: Label = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/Label_wealth
@onready var label_parent: Label = $Sprite2D_Background/CanvasLayer_UILayer/StatsContainer/Label_parent

@onready var start_game_button: Button = $Sprite2D_Background/CanvasLayer_UILayer/Button_StartGame

func _ready():
	LocalizationManager.load("origin")
	
	start_game_button.pressed.connect(_on_new_game_start_pressed)

	# Локализация заголовков
	label_caption.text = LocalizationManager.t("origin", "title")
	label_wealth.text = LocalizationManager.t("origin", "wealth_label")
	label_parent.text = LocalizationManager.t("origin", "parent_label")

	# Заполнение опций
	wealth_selector.clear()
	wealth_selector.add_item(LocalizationManager.t("origin", "wealth_rich"))     # index 0
	wealth_selector.add_item(LocalizationManager.t("origin", "wealth_average"))  # index 1
	wealth_selector.add_item(LocalizationManager.t("origin", "wealth_poor"))     # index 2

	parent_selector.clear()
	parent_selector.add_item(LocalizationManager.t("origin", "parent_both"))     # index 0
	parent_selector.add_item(LocalizationManager.t("origin", "parent_mother"))   # index 1
	parent_selector.add_item(LocalizationManager.t("origin", "parent_father"))   # index 2
	parent_selector.add_item(LocalizationManager.t("origin", "parent_orphan"))   # index 3

	# Подключение сигналов
	wealth_selector.item_selected.connect(_update_result)
	parent_selector.item_selected.connect(_update_result)

	# Инициализация
	_update_result()

func _update_result(_index := 0):
	var wealth_keys = ["desc_wealth_rich", "desc_wealth_average", "desc_wealth_poor"]
	var parent_keys = ["desc_parent_both", "desc_parent_mother", "desc_parent_father", "desc_parent_orphan"]

	var desc_wealth = LocalizationManager.t("origin", wealth_keys[wealth_selector.selected])
	var desc_parent = LocalizationManager.t("origin", parent_keys[parent_selector.selected])

	label_result.text = desc_wealth + "\n" + desc_parent

func _on_new_game_start_pressed():
	print("Новая игра начата!")
	#get_tree().change_scene_to_file("res://scenes/node_2d_video_stream_player_cutscene.tscn


func _on_button_start_game_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/node_2d_video_stream_player_cutscene.tscn")
