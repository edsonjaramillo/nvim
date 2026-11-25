; extends

; ArkType: highlight string definitions as TypeScript

; type("string.email"), scope("..."), generic("...")
(call_expression
  function: (identifier) @_fn
  arguments: (arguments
    (string (string_fragment) @injection.content))
  (#any-of? @_fn "type" "scope" "generic" "define")
  (#set! injection.language "typescript"))

; type.module("..."), x.and("..."), x.or("...") ...
(call_expression
  function: (member_expression
    property: (property_identifier) @_m)
  arguments: (arguments
    (string (string_fragment) @injection.content))
  (#any-of? @_m "and" "or" "intersect" "merge" "extends" "pipe" "to" "module")
  (#set! injection.language "typescript"))

; type({ email: "string.email", age: "number > 0" })
(call_expression
  function: (identifier) @_fn
  arguments: (arguments
    (object
      (pair
        value: (string (string_fragment) @injection.content))))
  (#any-of? @_fn "type" "scope")
  (#set! injection.language "typescript"))

; type(["string", "number"])  (tuples)
(call_expression
  function: (identifier) @_fn
  arguments: (arguments
    (array
      (string (string_fragment) @injection.content)))
  (#eq? @_fn "type")
  (#set! injection.language "typescript"))
