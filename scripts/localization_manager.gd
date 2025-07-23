extends Node

var current_language: String = "ru"
var loaded_data: Dictionary = {}  # { "имя_файла": { "ключ": "строка" } }

func set_language(lang: String) -> void:
	current_language = lang
	loaded_data.clear()

func load(file_name: String) -> void:
	if loaded_data.has(file_name):
		return  # уже загружен

	var path = "res://locales/%s/%s.json" % [current_language, file_name]
	if not FileAccess.file_exists(path):
		push_warning("Файл локализации не найден: %s" % path)
		return

	var file := FileAccess.open(path, FileAccess.READ)
	if file:
		var text := file.get_as_text()
		var parsed: Dictionary = JSON.parse_string(text)
		if typeof(parsed) == TYPE_DICTIONARY:
			loaded_data[file_name] = parsed
		else:
			push_error("Ошибка разбора JSON: %s" % path)
	else:
		push_error("Не удалось открыть файл: %s" % path)

# Получить перевод по ключу из конкретного файла
func t(file_name: String, key: String) -> String:
	if not loaded_data.has(file_name):
		load(file_name)

	return loaded_data.get(file_name, {}).get(key, "[%s/%s]" % [file_name, key])

# Попробовать перевести строку как ключ из shared.json
func translate_stat_value(value: Variant) -> Variant:
	if typeof(value) == TYPE_STRING:
		# Убедимся, что shared загружен
		if not loaded_data.has("shared"):
			load("shared")

		return loaded_data.get("shared", {}).get(value, value)
	
	return value
