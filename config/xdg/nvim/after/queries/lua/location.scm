; Functions
((function_declaration
	name: (identifier) @function-name) @root)

((function_declaration
	name: (dot_index_expression) @table-function) @root)

; Function assined to variables
((assignment_statement
	(variable_list
		name: (identifier) @function-name)
	(expression_list
		value: (function_definition))) @root)

((assignment_statement
	(variable_list
		name: (dot_index_expression) @table-function)
	(expression_list
		value: (function_definition))) @root)

; Methods
((field
	name: (identifier) @method-name
	value: (function_definition)) @root)

((field
	name: (string) @string-method
	value: (function_definition)) @root)

; Tables
((assignment_statement
	(variable_list
		name: (_) @multi-container)
	(expression_list
		value: (table_constructor))) @root)

; Table inside table
((field
	name: (identifier) @container-name
	value: (table_constructor)) @root)
