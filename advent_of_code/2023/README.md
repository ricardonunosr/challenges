# Common Lisp

Book
https://gigamonkeys.com/book/

Inventor
https://en.wikipedia.org/wiki/John_McCarthy_(computer_scientist)

```bash
clisp 01.lsp
```

Functions
```lisp
(defun hello-world () (format t "hello, world"))
```

Load File
```lisp
(load "hello.lisp")
(load (compile-file "hello.lisp"))
```

- Common Lisp provides three distinct kinds of operators: functions, macros, and special operators

Property List (plist)
```lisp
(list :a 1 :b 2 :c 3)
```

Global variables
-The asterisks (*) in the name are a Lisp naming convention for global variables. 
```lisp
(defvar *db* nil)
```

Format
-t is shorthand for the stream *standard-output*.
```lisp
(format t "~a" "Dixie Chicks")
```
