; (call_expression 
;   function: (selector_expression 
; 	operand: (_) 
; 	field: (field_identifier) @_field
; 	)
;   arguments: (argument_list) @sql
;   (#eq? @_field "Query")
;   (#offset! @sql 0 1 0 -1)
; )
; below, the `.` makes it match the first argument, which might be JS
(call_expression 
	function: (selector_expression field: (field_identifier) @_field) 
	arguments: (argument_list  . (interpreted_string_literal) @javascript)
	(#eq? @_field "RunScript")
  (#offset! @javascript 0 1 0 -1)
)


