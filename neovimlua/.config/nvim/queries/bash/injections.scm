(
 command 
  name: (command_name) @_cmd (#eq? @_cmd "mongosh")
  argument: (word) @_arg (#eq? @_arg "--eval") 
  argument: (raw_string) @typescript (#offset! @typescript 0 1 0 -1)
)


(
 command 
  name: (command_name) @_cmd (#eq? @_cmd "psql")
  argument: (word) @_arg (#eq? @_arg "-c") 
  argument: (raw_string) @sql (#offset! @sql 0 1 0 -1)
)

(
 (pipeline 
   (command 
    name: (command_name) @_cmd (#eq? @_cmd "kubectl")
    argument: (word) @_arg1 (#eq? @_arg1 "apply") 
    argument: (word) @_arg2 (#eq? @_arg2 "-f") 
    argument: (word) @_arg3 (#eq? @_arg3 "-") 
  )
 )
 (heredoc_body) @yaml
) 


