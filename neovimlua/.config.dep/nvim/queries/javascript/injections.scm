(call_expression 
	function: (member_expression 
			object: (identifier) 
			property: (property_identifier) @_prop) 
	arguments: (arguments 
			(string (string_fragment) @css)) 
	(#eq? @_prop "locator")
)
(
 [
	(string_fragment) @html
  (template_string) @html
 ]
 (#contains? @html  "<!DOCTYPE html>" "<html" "<div" "<p" "<body" "<head>")
)

; extends

; /* html */ `<html>`
; /* sql */ `SELECT * FROM foo`
(variable_declarator
  (comment) @injection.language (#offset! @injection.language 0 3 0 -3)
  (template_string) @injection.content (#offset! @injection.content 0 1 0 -1)
  )

; foo(/* html */ `<span>`)
; foo(/* sql */ `SELECT * FROM foo`)
(call_expression
  arguments: [
              (arguments
                (comment) @injection.language (#offset! @injection.language 0 3 0 -3)
                (template_string) @injection.content (#offset! @injection.content 0 1 0 -1)
                )
              ]
  )
