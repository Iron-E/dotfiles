;; extends

; builtins

((symbol) @keyword
          (#any-of? @keyword "define*" "rec"))

((symbol) @keyword.conditional
          (#any-of? @keyword.conditional "match"))

((symbol) @keyword.function
          (#any-of? @keyword.function
			  "λ" "lambda" "lambda*"
			  "case-lambda" "case-lambda*"
			  "match-lambda" "match-lambda*"))

(list
  .
  (symbol) @keyword.function
  .
  (list)
  (#lua-match? @keyword.function "^define"))

((symbol) @keyword.import
			 (#any-of? @keyword.import "use-modules" "use-srfis"))

((symbol) @keyword.import
  (#any-of? @keyword.import "use-modules")
  (list . (symbol) @module.builtin
      (#any-of? @module.builtin "ice-9" "srfi" "scheme" "rnrs" "oop"))*)

((symbol) @_sym
  (#any-of? @_sym "use-modules")
  (list . (symbol) @module.builtin
      (#not-any-of? @module.builtin "ice-9" "srfi" "scheme" "rnrs" "oop"))*)

((symbol) @keyword.operator
          (#any-of? @keyword.operator "and" "not" "or"))

((symbol) @keyword.repeat
          (#any-of? @keyword.repeat "do" "while"))

((symbol) @operator
          (#any-of? @operator "1+" "1-"))

((symbol) @punctuation.delimiter
          (#any-of? @punctuation.delimiter "=>"))

((symbol) @function.builtin
          (#any-of?
			  @function.builtin
			  "array?"
			  "atomic-box?"
			  "bignum?"
			  "bitvector?"
			  "bytevector?"
			  "compnum?"
			  "dynamic-state?"
			  "eq-false?" "false?"
			  "eq-nil?" "nil?"
			  "eq-null?" "null?"
			  "eq-true?" "true?"
			  "flonum?"
			  "fluid?"
			  "fracnum?"
			  "frame?"
			  "hash-table?"
			  "heap-number?"
			  "immutable-vector?"
			  "keyword?"
			  "mutable-vector?"
			  "pair?"
			  "parameterize"
			  "pointer?"
			  "port?"
			  "program?"
			  "smob?"
			  "stringbuf?"
			  "struct?"
			  "syntax?"
			  "unspecified?"
			  "variable?"
			  "vector?"
			  "vm-continuation?"
			  "weak-set?"
			  "weak-table?"
			  "weak-vector?"))

; identifiers

(list
  .
  (symbol) @_let_values
  .
  (symbol)? ; label
  .
  (list
	 (list
		.
		(list . (symbol) @variable)))
  (#any-of? @_let_values "let-values" "let*-values"))

(list
  .
  (symbol) @_let
  .
  (symbol)? ; label
  .
  (list
	 (list . (symbol) @variable))
  (#any-of? @_let "let" "let*" "letrec" "letrec*" "let"))

(list
  .
  (symbol) @_do
  .
  (list
	 (list . (symbol) @variable))
  (#any-of? @_do "do"))

; keywords

((keyword) @constant.macro)

((keyword) @punctuation.special @punctuation.delimiter
  (#lua-match? @punctuation.special "^#:.")
  (#offset-from! "start" @punctuation.special 0 0 0 1)
  (#offset-from! "start" @punctuation.delimiter 0 1 0 2))

((keyword) @punctuation.delimiter
  (#lua-match? @punctuation.delimiter "^:.")
  (#offset-from! "start" @punctuation.delimiter 0 0 0 1))

((keyword) @punctuation.delimiter
  (#not-lua-match? @punctuation.delimiter "^[#:].")
  (#lua-match? @punctuation.delimiter ":$")
  (#offset-from! "end" @punctuation.delimiter 0 -1 0 0))

; punctuation

(quasiquote "`" @punctuation.special)
(quote "'" @punctuation.special)
(unquote "," @punctuation.special)

(vector "#(" @punctuation.bracket)

(list
  .
  (symbol) @keyword.import
  .
  (list)
  .
  (symbol)
  (#any-of? @keyword.import "@" "@@"))

((boolean) @punctuation.special
  (#offset-from! "start" @punctuation.special 0 0 0 1))

((symbol) @punctuation.special
  (#offset-from! "start" @punctuation.special 0 0 0 1)
  (#lua-match? @punctuation.special "^%p")
  (#not-lua-match? @punctuation.special "^%p+$")
  (#not-any-of? @punctuation.special "1-" "1+"))

((symbol) @punctuation.special
  (#offset-from! "end" @punctuation.special 0 -1 0 0)
  (#lua-match? @punctuation.special "%p$")
  (#not-lua-match? @punctuation.special "^%p+$")
  (#not-any-of? @punctuation.special "1-" "1+"))
