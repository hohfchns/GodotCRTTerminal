extends Control

onready var terminal = $Terminal

# Put the function or code you want the terminal to run here!
func _ready():
	terminal.clear()
	
	
	var input = yield(terminal.get_input("Type some test input: "), "completed")
	terminal.print_line(input + "\n")
	
	var string = yield(wait_for_input("Press any key to continue"), "completed")
	terminal.clear()
	
#	terminal.print_line(string)
	hidden_input()


func basic_test_print():
	var input = yield(terminal.get_input(), "completed")
	terminal.clear()
	terminal.print_line("I cleared the screen, to make things more \"clear\"!")
	for i in range(7):
		terminal.print_line("")
	terminal.print_line("I also added a few lines to center the text!")
	terminal.print_line("Here is your input by the way:\n%s" % input)
	var input2 = yield(terminal.get_input("Thanks for the input sucker, now give me more: "), "completed")
	terminal.print_line("Here is your new input: \n%s" % input2)


func fizzbuzz():
	for i in range(100):
		if i % 5 == 0 and i % 7 == 0:
			terminal.print_line("FizzBuzz")
			continue
		elif i % 5 == 0:
			terminal.print_line("Fizz")
			continue
		elif i % 7 == 0:
			terminal.print_line("Buzz")
			continue
		
		terminal.print_line(str(i))


func reverse_string():
	var input_string: String = yield(terminal.get_input("Type a string, and you'll get the reverse of it! "), "completed")
	var new_string = ""
	for i in range(input_string.length() -1, -1, -1):
		new_string += input_string[i]
	terminal.print_line("Here is your reversed string: " + new_string)


func hidden_input():
	var input_string: String = yield(terminal.get_input("Hey, type something, I promise I won't show it! ", true), "completed")
	terminal.print_line("Just kidding! Here is what you typed! " + input_string)


func wait_for_input(text: String):
	terminal.print_line(text)
	return yield(terminal, "input_processed")
