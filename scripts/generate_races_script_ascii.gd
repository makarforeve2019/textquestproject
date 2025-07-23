extends Node

func _ready():
	var base_path = "res://generated"
	var races_dir = base_path + "/races"
	var locales_ru = base_path + "/locales/ru"
	var locales_en = base_path + "/locales/en"

	DirAccess.make_dir_recursive_absolute(races_dir)
	DirAccess.make_dir_recursive_absolute(locales_ru)
	DirAccess.make_dir_recursive_absolute(locales_en)

	var shared_ru = {}
	var shared_en = {}

	DirAccess.make_dir_recursive_absolute(races_dir + "/chelovek")
	var stats_chelovek = {
		"name": "race_chelovek_name",
		"strength": 0,
		"reaction": 0,
		"intellect": 0,
		"empathy": 0,
		"description": "race_chelovek_desc"
	}
	var f_chelovek = FileAccess.open(races_dir + "/chelovek/stats.json", FileAccess.WRITE)
	f_chelovek.store_string(JSON.stringify(stats_chelovek, "\t"))
	f_chelovek.close()

	shared_ru["race_chelovek_name"] = "Человек"
	shared_ru["race_chelovek_desc"] = "Стандартный и самый скучный класс. Не оладает особыми баффами или дебаффами"
	shared_ru["race_chelovek_abilities"] = "Ни в чем не хорошо, но и ни в чем не плох"

	shared_en["race_chelovek_name"] = "[Chelovek]"
	shared_en["race_chelovek_desc"] = "[Description for chelovek]"
	shared_en["race_chelovek_abilities"] = "[Abilities for chelovek]"

	DirAccess.make_dir_recursive_absolute(races_dir + "/golem")
	var stats_golem = {
		"name": "race_golem_name",
		"strength": 0,
		"reaction": 0,
		"intellect": 0,
		"empathy": 0,
		"description": "race_golem_desc"
	}
	var f_golem = FileAccess.open(races_dir + "/golem/stats.json", FileAccess.WRITE)
	f_golem.store_string(JSON.stringify(stats_golem, "\t"))
	f_golem.close()

	shared_ru["race_golem_name"] = "Голем (каменный человек)"
	shared_ru["race_golem_desc"] = "Люди выдолбленные из скалы обычными людьми, для защиты мира от Иных"
	shared_ru["race_golem_abilities"] = "Устойчив к огню, боится холода. Имеет врожденную броню, одинаково защищающую от физический и магических атак. Баффы к силе и реакции. Дебаффы к уму и эмпатии."

	shared_en["race_golem_name"] = "[Golem]"
	shared_en["race_golem_desc"] = "[Description for golem]"
	shared_en["race_golem_abilities"] = "[Abilities for golem]"

	DirAccess.make_dir_recursive_absolute(races_dir + "/inye")
	var stats_inye = {
		"name": "race_inye_name",
		"strength": 0,
		"reaction": 0,
		"intellect": 0,
		"empathy": 0,
		"description": "race_inye_desc"
	}
	var f_inye = FileAccess.open(races_dir + "/inye/stats.json", FileAccess.WRITE)
	f_inye.store_string(JSON.stringify(stats_inye, "\t"))
	f_inye.close()

	shared_ru["race_inye_name"] = "Иные"
	shared_ru["race_inye_desc"] = "Однажды появились из ниоткуда в мире людей, пытались их захватить, но проиграли. Теперь живут со всеми в мире. Научили людей магии."
	shared_ru["race_inye_abilities"] = "Устойчивы к холоду, боятся огня. Мягкотелы, больше получают урона, зато отлично владеют магией. Дебаффы к силе и реакции. Баффы к уму и эмпатии."

	shared_en["race_inye_name"] = "[Inye]"
	shared_en["race_inye_desc"] = "[Description for inye]"
	shared_en["race_inye_abilities"] = "[Abilities for inye]"

	DirAccess.make_dir_recursive_absolute(races_dir + "/slepen")
	var stats_slepen = {
		"name": "race_slepen_name",
		"strength": 0,
		"reaction": 0,
		"intellect": 0,
		"empathy": 0,
		"description": "race_slepen_desc"
	}
	var f_slepen = FileAccess.open(races_dir + "/slepen/stats.json", FileAccess.WRITE)
	f_slepen.store_string(JSON.stringify(stats_slepen, "\t"))
	f_slepen.close()

	shared_ru["race_slepen_name"] = "Слепень (подкласс)"
	shared_ru["race_slepen_desc"] = "Типа вампир, слепой, пологается на эхолокацию. Другое взаимодействие с миром, другой геймплей. Проклятые за предательство."
	shared_ru["race_slepen_abilities"] = "Дебафф к реакции. Бафы в остальных навыках. Обычные расы будут атакавать его"

	shared_en["race_slepen_name"] = "[Slepen]"
	shared_en["race_slepen_desc"] = "[Description for slepen]"
	shared_en["race_slepen_abilities"] = "[Abilities for slepen]"

	DirAccess.make_dir_recursive_absolute(races_dir + "/likantrop")
	var stats_likantrop = {
		"name": "race_likantrop_name",
		"strength": 0,
		"reaction": 0,
		"intellect": 0,
		"empathy": 0,
		"description": "race_likantrop_desc"
	}
	var f_likantrop = FileAccess.open(races_dir + "/likantrop/stats.json", FileAccess.WRITE)
	f_likantrop.store_string(JSON.stringify(stats_likantrop, "\t"))
	f_likantrop.close()

	shared_ru["race_likantrop_name"] = "Ликантроп (подкласс)"
	shared_ru["race_likantrop_desc"] = "Зараженные лекантропией. Игрок с данным подклассом должен будет время от времени сопротивляться превращению (в зависимости от ситуации и наоборот). При превращении происходит ряд малоприятных случайных событий. Типо убийства дружественных НПС. Меняет геймплей."
	shared_ru["race_likantrop_abilities"] = "Бафы к силе и реакции. Неприятные последствия превращения."

	shared_en["race_likantrop_name"] = "[Likantrop]"
	shared_en["race_likantrop_desc"] = "[Description for likantrop]"
	shared_en["race_likantrop_abilities"] = "[Abilities for likantrop]"

	var file_ru = FileAccess.open(locales_ru + "/shared.json", FileAccess.WRITE)
	file_ru.store_string(JSON.stringify(shared_ru, "\t"))
	file_ru.close()

	var file_en = FileAccess.open(locales_en + "/shared.json", FileAccess.WRITE)
	file_en.store_string(JSON.stringify(shared_en, "\t"))
	file_en.close()

	print("✅ Все файлы сгенерированы (ASCII-only)")
