; Struct and Interface
((package_clause (package_identifier) @package)
 ((type_spec
    name: (type_identifier) @struct) @root))

; Function
((function_declaration
   name: (identifier) @function) @root)

; Method
((method_declaration
   receiver: (parameter_list
               (parameter_declaration
                 type: (type_identifier) @struct))
   name: (field_identifier) @method) @root)

; Method with pointer
((method_declaration
   receiver: (parameter_list
               (parameter_declaration
                 type: (pointer_type
                         (type_identifier) @struct)))
   name: (field_identifier) @method) @root)
