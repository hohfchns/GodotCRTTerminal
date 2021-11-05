class_name CRTTerminal
extends Control

enum e_input_states {
	NO_INPUT,
	INPUT_SHOWN,
	INPUT_HIDDEN
}

var m_input_state: int = e_input_states.NO_INPUT

onready var m_scroll: ScrollContainer = $ScrollContainer
onready var m_scrollbar: VScrollBar = $ScrollContainer.get_v_scrollbar()
onready var m_text: Label = $ScrollContainer/Text

var m_cur_input: String = ""

signal input_recieved
signal input_processed(key_str)
signal stop_input


func _input(event):
	if not event is InputEventKey:
		return
	
	var just_pressed = event.is_pressed() and not event.is_echo()
	if not just_pressed:
		return
	
	emit_signal("input_recieved")
	
	var string = event.as_text()
	
	if m_input_state == e_input_states.NO_INPUT:
		emit_signal("input_processed", string)
		return
	
	if string == "Enter":
		emit_signal("input_processed", string)
		emit_signal("stop_input")
		return
	
	if string == "BackSpace":
		if m_cur_input == "":
			emit_signal("input_processed", string)
			return
		
		m_cur_input.erase(m_cur_input.length() - 1, 1)
		
		if m_input_state != e_input_states.INPUT_HIDDEN:
			var new_text = m_text.text
			new_text.erase(m_text.text.length() - 1, 1)
			m_text.text = new_text
		
		emit_signal("input_processed", string)
		return
	
	if m_input_state != e_input_states.INPUT_HIDDEN:
		print_string(string)
		emit_signal("input_processed", string)
	
	m_cur_input += string
	
	emit_signal("input_processed", string)


func scroll_to_bottom() -> void:
	yield(get_tree(), "idle_frame")
	m_scroll.scroll_vertical = m_scrollbar.max_value


func print_string(text) -> void:
	scroll_to_bottom()
	m_text.text += text

func print_line(text) -> void:
	scroll_to_bottom()
	m_text.text += text + "\n"

func get_input(request_text: String = "", hide_input: bool = false) -> String:
	m_cur_input = ""
	
	if request_text:
		print_string(request_text)
	
	if hide_input:
		m_input_state = e_input_states.INPUT_HIDDEN
	else:
		m_input_state = e_input_states.INPUT_SHOWN
	
	yield(self, "stop_input")
	
	m_text.text += "\n"
	m_input_state = e_input_states.NO_INPUT
	return m_cur_input


func reset_input() -> void:
	if m_input_state == e_input_states.INPUT_SHOWN:
		var new_text = m_text.text
		new_text.erase(m_text.text.length() - m_cur_input.length(), m_cur_input.length())
		m_text.text = new_text
	
	m_cur_input = ""


func clear() -> void:
	m_text.text = ""
