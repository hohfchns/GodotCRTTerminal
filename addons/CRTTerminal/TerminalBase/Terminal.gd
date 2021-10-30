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

signal stop_input


func _input(event):
	if not event is InputEventKey:
		return
	
	var just_pressed = event.is_pressed() and not event.is_echo()
	if not just_pressed:
		return
	
	var string = event.as_text()
	
	if m_input_state == e_input_states.NO_INPUT:
		print("returning")
		return
	
	if string == "Enter":
		emit_signal("stop_input")
		return
	
	if string == "BackSpace":
		m_cur_input.erase(m_cur_input.length() - 1, 1)
		var new_text = m_text.text
		new_text.erase(m_text.text.length() - 1, 1)
		m_text.text = new_text
		return
	
	if m_input_state == e_input_states.INPUT_SHOWN:
		print("shown")
		print_string(string)
	
	m_cur_input += string


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



func clear():
	m_text.text = ""
