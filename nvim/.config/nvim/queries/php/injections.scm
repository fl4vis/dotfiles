;; extends

; Inject SQL query on vars that contain query, or sql

(
 expression_statement
  (assignment_expression
    left: (variable_name
        (name) @id
        (#match? @id"([qQ]uery|[sS]ql)")
    ) 
    right: (encapsed_string
             (string_content) @injection.content
             (#set! injection.language "sql")
             (#set! injection.include-children)
        )
   )
) 

(expression_statement
  (assignment_expression
    right: (scoped_call_expression 
       scope: (name) @id
              (#match? @id"DB")
       arguments: (arguments
            (argument
              (encapsed_string
                (string_content) @injection.content
                 (#set! injection.language "sql")
                 (#set! injection.include-children)
              ) 
            )
       ) 
    )
  )
)

(expression_statement 
(scoped_call_expression 
  scope: (name)  @id
         (#match? @id"DB")
  arguments: (arguments 
    (argument
     (encapsed_string
        (string_content)  @injection.content
         (#set! injection.language "sql")
         (#set! injection.include-children)
     ) 
    )
   ) 
))

; HTML

(assignment_expression
  left: (variable_name 
    (name))
  right: (binary_expression) @injection.content  
  (#lua-match? @injection.content "<%s*[a-zA-Z][%w%-]*[%s>]")
  (#set! injection.language "html")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
) 


