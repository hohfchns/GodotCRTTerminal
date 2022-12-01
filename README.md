# Godot CRT Terminal

A simple CRT terminal in Godot with basic input/output functionality

You can likely just use the code and swap out the shader/ui for your use case

# Notice
This project is for Godot 3, and will not work with Godot 4

# Usage
Usage is simple, some sample code can be found in the examples folder, but here is some simple input and output:

```gdscript
# This assumes you have a root node that has a terminal as a child of it
extends Control
# Class name is optional
class_name TerminalExample

# Get the terminal's root node
onready var terminal = $Terminal

func _ready():
  # Printing lines is a simple function call
  terminal.print_line("This is a line, printed on the terminal")

  # You can also print a string directly, without the automatic line ending
  terminal.print_string("This is a line, manually ended\n")

  # To get user input you need to yield the function to wait until it finished.
  var user_input = yield(terminal.get_input("Type some input! "), "completed")

  # Clear the terminal of all text
  terminal.clear()

  # Finally, print the input that was saved into the variable
  terminal.print_line(user_input)
```

# Credits
This project uses the CRT Shader made by arlez80 on godotshaders.com and can be found in the following link:
https://godotshaders.com/shader/crt-shader/
