; (
;  command 
;   name: (command_name) @_cmd (#any-of? @_cmd "mongosh" "mongo")
;   argument: (word) @_arg (#eq? @_arg "--eval") 
;   argument: [(raw_string) (string)] @typescript (#offset! @typescript 0 1 0 -1)
; )
;
; (
;  command 
;   name: (command_name) @_cmd (#any-of? @_cmd "python" "python3")
;   argument: (word) @_arg (#eq? @_arg "-c") 
;   argument: [(raw_string) (string)] @python
; 	(#offset! @python 0 1 0 -1)
; )
;
; (
;  command 
;   name: (command_name) @_cmd (#eq? @_cmd "psql")
;   argument: (word) @_arg (#eq? @_arg "-c") 
;   argument: [(raw_string) (string)] @sql (#offset! @sql 0 1 0 -1)
; )
;
; (
;  (pipeline 
;    (command 
;     name: (command_name) @_cmd (#eq? @_cmd "kubectl")
;     argument: (word) @_arg1 (#eq? @_arg1 "apply") 
;     argument: (word) @_arg2 (#eq? @_arg2 "-f") 
;     argument: (word) @_arg3 (#eq? @_arg3 "-") 
;   )
;  )
;  (heredoc_body) @yaml
; ) 
;
; (
;  command 
;   name: (command_name) @_cmd (#eq? @_cmd "curl")
;   argument: (word) @_arg (#eq? @_arg "--data-raw") 
;   argument: [(raw_string) (string)] @json
; 	(#offset! @json 0 1 0 -1)
; )
;
