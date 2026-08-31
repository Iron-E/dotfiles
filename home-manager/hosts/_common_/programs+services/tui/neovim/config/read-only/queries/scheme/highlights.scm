;; extends

(quasiquote "`" @punctuation.special)
(quote "'" @punctuation.special)
(unquote "," @punctuation.special)

((symbol) @keyword.import
	(#any-of? @keyword.import "use-modules" "use-srfis")
	(list . (symbol) @module.builtin
			(#any-of? @module.builtin "ice-9" "srfi")))

((symbol) @_sym
	(#any-of? @_sym "use-modules" "use-srfis")
	(list . (symbol) @module
			(#not-any-of? @module "ice-9" "srfi")))

((symbol) @keyword.import
	(#any-of? @keyword.import "use-modules" "use-srfis"))

((keyword) @constant.macro)

((keyword) @punctuation.special @punctuation.delimiter
	(#lua-match? @punctuation.special "^#:")
	(#offset-from! "start" @punctuation.special 0 0 0 1)
	(#offset-from! "start" @punctuation.delimiter 0 1 0 2))

((keyword) @punctuation.delimiter
	(#lua-match? @punctuation.delimiter "^:")
	(#offset-from! "start" @punctuation.delimiter 0 0 0 1))

((keyword) @punctuation.delimiter
	(#not-lua-match? @punctuation.delimiter "^[#:]")
	(#lua-match? @punctuation.delimiter ":$")
	(#offset-from! "end" @punctuation.delimiter 0 -1 0 0))

((boolean) @punctuation.special
	(#offset-from! "start" @punctuation.special 0 0 0 1))

((symbol) @punctuation.special
	(#offset-from! "end" @punctuation.special 0 -1 0 0)
	(#lua-match? @punctuation.special "[%*!]$"))
