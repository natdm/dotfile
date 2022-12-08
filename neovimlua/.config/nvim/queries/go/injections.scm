(call_expression 
  function: (selector_expression 
	operand: (_) 
	field: (field_identifier) @_field
	)
  arguments: (argument_list) @sql
  (#eq? @_field "Query")
  (#offset! @sql 0 1 0 -1)
)

