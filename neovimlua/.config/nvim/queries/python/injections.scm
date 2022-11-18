((string) @sql 
  (#contains? @sql "SELECT" "INSERT" "UPDATE" "DELETE" "CREATE" "ALTER" "select" "insert" "update" "delete" "create" "alter") 
  (#offset! @sql 1 0 -1 0))

