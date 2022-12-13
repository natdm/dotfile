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
 (#contains? @html  "<!DOCTYPE html>" "<html" "<div>" "<p>" "<body>" "<head>")
)


