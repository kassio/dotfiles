; Class
((class_declaration
   name: (identifier) @class
   body: (class_body)) @root)

; Function
((function_declaration
   name: (identifier) @function
   body: (statement_block)) @root)

; Method
((method_definition
   name: (property_identifier) @method
   body: (statement_block)) @root)

; Arrow Function
((variable_declarator
   name: (identifier) @function
   value: (arrow_function)) @root)

; Function Expression
((variable_declarator
   name: (identifier) @function
   value: (function)) @root)

; Tests
((expression_statement
   (call_expression
     function: (identifier)
     arguments: (arguments
                  (string) @method
                  (arrow_function)))) @root)

; Arrow function methods
((field_definition
   property: (property_identifier) @method
   value: (arrow_function)) @root)

; object literal
((variable_declarator
   name: (identifier) @object
   value: (object)) @root)

; object literal modification
((assignment_expression
   left: (identifier) @object
   right: (object)) @root)

; nested objects
((pair
   key: (property_identifier) @object
   value: (_)) @root)

; nested objects with computed_property_name e.g. { [bar] : true }
((pair
   key: (computed_property_name) @object
   value: (_)) @root)

; object property modification
((assignment_expression
   left: (member_expression) @object
   right: (object)) @root)

; array
((variable_declarator
   name: (identifier) @array
   value: (array)) @root)

; array modification
((assignment_expression
   left: (identifier) @array
   right: (array)) @root)
