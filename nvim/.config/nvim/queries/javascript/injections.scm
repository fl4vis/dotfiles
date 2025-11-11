; HTML detection
((template_string) @injection.content
  (#lua-match? @injection.content "<%s*[a-zA-Z][%w%-]*[%s>]")
  (#set! injection.language "html")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
 )

