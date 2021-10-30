extends Control

onready var terminal = $Terminal

# Put the function or code you want the terminal to run here!
func _ready():
	reverse_string()


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
