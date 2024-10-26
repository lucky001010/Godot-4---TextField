extends Node2D

@onready var input_field = $InputField
@onready var output_label = $OutputLabel
@onready var submit_button = $SubmitButton

func _ready():
	# Используем Callable для корректной передачи метода
	submit_button.connect("gui_input", Callable(self, "_on_SubmitButton_gui_input"))
	load_text()  # Загружаем сохраненный текст при старте

func _on_SubmitButton_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var text = input_field.text  # Получаем текст из поля ввода
		output_label.text = text     # Устанавливаем текст в Label
		save_text(text)              # Сохраняем текст в файл

func save_text(text: String):
	var save_path = "user://saved_text.txt"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(text)
		file.close()

func load_text():
	var load_path = "user://saved_text.txt"
	if FileAccess.file_exists(load_path):
		var file = FileAccess.open(load_path, FileAccess.READ)
		if file:
			output_label.text = file.get_as_text()
			file.close()
