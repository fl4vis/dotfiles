;; extends

; Inject SQL query on vars that use `` and contain query, layer, or sql
(
  short_var_declaration
    left: (expression_list
            (identifier) @id
            (#match? @id "([qQ]uery|[lL]ayer|[sS]ql)")
      )
    right: (expression_list
              (raw_string_literal) @injection.content
              (#offset! @injection.content 0 1 0 -1)
              (#set! injection.language "sql")
              (#set! injection.include-children)
      )
)


(
  short_var_declaration
    left: (expression_list
            (identifier) @id
            (#match? @id "([qQ]uery|[lL]ayer|[sS]ql)")
      )
    right: (expression_list (
        call_expression
        arguments: (argument_list
            (raw_string_literal (
             raw_string_literal_content) @injection.content
              (#offset! @injection.content 0 1 0 -1)
              (#set! injection.language "sql")
              (#set! injection.include-children)
            ) 
        ) 
     )
   )
)

(assignment_statement
  left: (expression_list
          (identifier) @id
          (#match? @id "([qQ]uery|[lL]ayer|[sS]ql)")
        )
  right:(expression_list
          (call_expression
            arguments: (argument_list
                (raw_string_literal
                  (raw_string_literal_content) @injection.content
                  (#offset! @injection.content 0 1 0 -1)
                  (#set! injection.language "sql")
                  (#set! injection.include-children)
                )
             ) 
          ) 
        )
) 




