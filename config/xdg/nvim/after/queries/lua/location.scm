; Functions
((function_declaration
   name: (identifier) @function) @root)

((function_declaration
   name: (dot_index_expression) @function) @root)

; Function assined to variables
((assignment_statement
   (variable_list
     name: (identifier) @function)
   (expression_list
     value: (function_definition))) @root)

((assignment_statement
   (variable_list
     name: (dot_index_expression) @function)
   (expression_list
     value: (function_definition))) @root)

; Methods
((field
   name: (identifier) @function
   value: (function_definition)) @root)

((field
   name: (string) @function
   value: (function_definition)) @root)

; Tables
((assignment_statement
   (variable_list
     name: (_) @container)
   (expression_list
     value: (table_constructor))) @root)

; Table inside table
((field
   name: (identifier) @container
   value: (table_constructor)) @root)
