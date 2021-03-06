
(module
    (import "std" "sleep" (func $sleep (param i32)))
    (import "std" "readln" (func $readln (param i32) (param i32) (result i32)))
    (import "std" "_ln" (func $_ln))
    (import "std" "_print" (func $_print (param i32) (param i32)))
    (import "std" "_println" (func $_println (param i32) (param i32)))
    (import "std" "print_int" (func $print_int (param i32)))
    (import "std" "print_real" (func $print_real (param f32)))
    (import "std" "println_int" (func $println_int (param i32)))
    (import "std" "println_real" (func $println_real (param f32)))
    (import "std" "print_int_pad" (func $print_int_pad (param i32) (param i32)))
    (import "std" "print_real_pad" (func $print_real_pad (param f32) (param i32)))

    (export "memory" (memory $mem))
    (export "str_len" (func $str_len))
    (export "str_copy" (func $str_copy))
    (export "str_end" (func $str_end))
    (export "str_cat" (func $str_cat))
    (export "main" (func $main))

    (func $str_len (param $po i32) (result i32)
        (local $idx i32)
        (block $out
            (loop $loop
                local.get $po
                local.get $idx
                i32.add
                i32.load8_u
                i32.eqz
                br_if $out
                local.get $idx
                i32.const 1
                i32.add
                local.set $idx
                br $loop
            )
        )
        local.get $idx
    )
    (func $str_copy (param $dest i32) (param $src i32)
        (local $c i32)
        (block $out
            (loop $loop
                local.get $src
                i32.load8_u
                local.tee $c
                i32.eqz
                br_if $out
                local.get $dest
                local.get $c
                i32.store8
                local.get $src
                i32.const 1
                i32.add
                local.set $src
                local.get $dest
                i32.const 1
                i32.add
                local.set $dest
                br $loop
            )
        )
    )
    (func $str_end (param $po i32) (result i32)
        (block $out
            (loop $loop
                local.get $po
                i32.load8_u
                i32.eqz
                br_if $out
                local.get $po
                i32.const 1
                i32.add
                local.set $po
                br $loop
            )
        )
        local.get $po
    )
    (func $print (param $po i32)
        local.get $po
        local.get $po
        call $str_len
        call $_print
    )
    (func $println (param $po i32)
        local.get $po
        call $print
        call $_ln
    )
    (func $str_cat (param $dest i32) (param $src i32)
        local.get $dest
        call $str_end
        local.get $src
        call $str_copy
    )

(memory $mem 16)
(global $fp (mut i32) (i32.const 0))
(global $sp (mut i32) (i32.const 0))

(global $temp_i32 (mut i32) (i32.const 0))
(global $temp_f32 (mut f32) (f32.const 0))

  (func $fac
  (param i32)
  (result i32)
  (get_global $sp)
  (i32.const 8)
  (i32.add)
  (set_global $sp)
  ;; n
  (get_global $fp)
  (i32.const 4)
  (i32.add)
  (get_local 0)
  (i32.store)
  ;; (Block 1 (IfStmt (<= "[integer]" (Var "n" "1,0" "[integer]") (Integer "[integer]" 1)) (Block 2 (return (Integer "[integer]" 1)))) (return (* "[integer]" (Var "n" "1,0" "[integer]") ("f(x)" "[integer]" (Var "fac" "0,9" "[(integer n)integer]") ( (- "[integer]" (Var "n" "1,0" "[integer]") (Integer "[integer]" 1)))))))
  ;; {
    ;; (IfStmt (<= "[integer]" (Var "n" "1,0" "[integer]") (Integer "[integer]" 1)) (Block 2 (return (Integer "[integer]" 1))))
    (block $b0
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (i32.const 1)
    (i32.le_s)
    (i32.eqz)
    (br_if $b0)
    ;; (Block 2 (return (Integer "[integer]" 1)))
    ;; {
      ;; (return (Integer "[integer]" 1))
      (i32.const 1)
      (return)
    ;; }
    )
    ;; (return (* "[integer]" (Var "n" "1,0" "[integer]") ("f(x)" "[integer]" (Var "fac" "0,9" "[(integer n)integer]") ( (- "[integer]" (Var "n" "1,0" "[integer]") (Integer "[integer]" 1))))))
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (i32.const 1)
    (i32.sub)
    (get_global $sp)
    (get_global $fp)
    (i32.store)
    (get_global $sp)
    (set_global $fp)
    (call $fac)
    (get_global $fp)
    (get_global $fp)
    (i32.load)
    (set_global $fp)
    (set_global $sp)
    (i32.mul)
    (return)
  ;; }
  (get_global $sp)
  (i32.const 8)
  (i32.sub)
  (set_global $sp)
  )

  (func $fac_iter
  (param i32)
  (result i32)
  (get_global $sp)
  (i32.const 16)
  (i32.add)
  (set_global $sp)
  ;; n
  (get_global $fp)
  (i32.const 4)
  (i32.add)
  (get_local 0)
  (i32.store)
  ;; (Block 3 (Block (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (Integer "[integer]" 1)))) (ForStmt (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 2))) (<= "[integer]" (Var "i" "3,2" "[integer]") (Var "n" "3,0" "[integer]")) (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (+ "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 1)))) (Block 4 (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (* "[integer]" (Var "acc" "3,1" "[integer]") (Var "i" "3,2" "[integer]")))))) (return (Var "acc" "3,1" "[integer]")))
  ;; {
    ;; (Block (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (Integer "[integer]" 1))))
    ;; {
      ;; (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (Integer "[integer]" 1)))
      (get_global $fp)
      (i32.const 8)
      (i32.add)
      (i32.const 1)
      (set_global $temp_i32)
      (get_global $temp_i32)
      (i32.store)
      (get_global $temp_i32)
      (drop)
    ;; }
    ;; (ForStmt (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 2))) (<= "[integer]" (Var "i" "3,2" "[integer]") (Var "n" "3,0" "[integer]")) (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (+ "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 1)))) (Block 4 (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (* "[integer]" (Var "acc" "3,1" "[integer]") (Var "i" "3,2" "[integer]"))))))
    ;; (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 2)))
    (get_global $fp)
    (i32.const 12)
    (i32.add)
    (i32.const 2)
    (set_global $temp_i32)
    (get_global $temp_i32)
    (i32.store)
    (get_global $temp_i32)
    (drop)
    (block $loopbrk0
    (loop $loopaux0
    (block $loop0
    (get_global $fp)
    (i32.const 12)
    (i32.add)
    (i32.load)
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (i32.le_s)
    (i32.eqz)
    (br_if $loopbrk0)
    ;; (Block 4 (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (* "[integer]" (Var "acc" "3,1" "[integer]") (Var "i" "3,2" "[integer]")))))
    ;; {
      ;; (ExprStmt (= "[integer]" (Var "acc" "3,1" "[integer]") (* "[integer]" (Var "acc" "3,1" "[integer]") (Var "i" "3,2" "[integer]"))))
      (get_global $fp)
      (i32.const 8)
      (i32.add)
      (get_global $fp)
      (i32.const 8)
      (i32.add)
      (i32.load)
      (get_global $fp)
      (i32.const 12)
      (i32.add)
      (i32.load)
      (i32.mul)
      (set_global $temp_i32)
      (get_global $temp_i32)
      (i32.store)
      (get_global $temp_i32)
      (drop)
    ;; }
    )
    ;; (ExprStmt (= "[integer]" (Var "i" "3,2" "[integer]") (+ "[integer]" (Var "i" "3,2" "[integer]") (Integer "[integer]" 1))))
    (get_global $fp)
    (i32.const 12)
    (i32.add)
    (get_global $fp)
    (i32.const 12)
    (i32.add)
    (i32.load)
    (i32.const 1)
    (i32.add)
    (set_global $temp_i32)
    (get_global $temp_i32)
    (i32.store)
    (get_global $temp_i32)
    (drop)
    (br $loopaux0)
    )
    )
    ;; (return (Var "acc" "3,1" "[integer]"))
    (get_global $fp)
    (i32.const 8)
    (i32.add)
    (i32.load)
    (return)
  ;; }
  (get_global $sp)
  (i32.const 16)
  (i32.sub)
  (set_global $sp)
  )

  (func $main
  (result i32)
  (get_global $sp)
  (i32.const 12)
  (i32.add)
  (set_global $sp)
  ;; (Block 5 (Block (ExprStmt (= "[integer]" (Var "x" "5,0" "[integer]") ("f(x)" "[integer]" (Var "fac" "0,9" "[(integer n)integer]") ( (Integer "[integer]" 6)))))) (Block (ExprStmt (= "[integer]" (Var "y" "5,1" "[integer]") ("f(x)" "[integer]" (Var "fac_iter" "0,10" "[(integer n)integer]") ( (Integer "[integer]" 6)))))) (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (Var "x" "5,0" "[integer]")))) (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (Var "y" "5,1" "[integer]")))) (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (== "[integer]" (Var "x" "5,0" "[integer]") (Var "y" "5,1" "[integer]"))))) (return (Integer "[integer]" 0)))
  ;; {
    ;; (Block (ExprStmt (= "[integer]" (Var "x" "5,0" "[integer]") ("f(x)" "[integer]" (Var "fac" "0,9" "[(integer n)integer]") ( (Integer "[integer]" 6))))))
    ;; {
      ;; (ExprStmt (= "[integer]" (Var "x" "5,0" "[integer]") ("f(x)" "[integer]" (Var "fac" "0,9" "[(integer n)integer]") ( (Integer "[integer]" 6)))))
      (get_global $fp)
      (i32.const 4)
      (i32.add)
      (i32.const 6)
      (get_global $sp)
      (get_global $fp)
      (i32.store)
      (get_global $sp)
      (set_global $fp)
      (call $fac)
      (get_global $fp)
      (get_global $fp)
      (i32.load)
      (set_global $fp)
      (set_global $sp)
      (set_global $temp_i32)
      (get_global $temp_i32)
      (i32.store)
      (get_global $temp_i32)
      (drop)
    ;; }
    ;; (Block (ExprStmt (= "[integer]" (Var "y" "5,1" "[integer]") ("f(x)" "[integer]" (Var "fac_iter" "0,10" "[(integer n)integer]") ( (Integer "[integer]" 6))))))
    ;; {
      ;; (ExprStmt (= "[integer]" (Var "y" "5,1" "[integer]") ("f(x)" "[integer]" (Var "fac_iter" "0,10" "[(integer n)integer]") ( (Integer "[integer]" 6)))))
      (get_global $fp)
      (i32.const 8)
      (i32.add)
      (i32.const 6)
      (get_global $sp)
      (get_global $fp)
      (i32.store)
      (get_global $sp)
      (set_global $fp)
      (call $fac_iter)
      (get_global $fp)
      (get_global $fp)
      (i32.load)
      (set_global $fp)
      (set_global $sp)
      (set_global $temp_i32)
      (get_global $temp_i32)
      (i32.store)
      (get_global $temp_i32)
      (drop)
    ;; }
    ;; (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (Var "x" "5,0" "[integer]"))))
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (get_global $sp)
    (get_global $fp)
    (i32.store)
    (get_global $sp)
    (set_global $fp)
    (call $println_int)
    (get_global $fp)
    (get_global $fp)
    (i32.load)
    (set_global $fp)
    (set_global $sp)
    ;; (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (Var "y" "5,1" "[integer]"))))
    (get_global $fp)
    (i32.const 8)
    (i32.add)
    (i32.load)
    (get_global $sp)
    (get_global $fp)
    (i32.store)
    (get_global $sp)
    (set_global $fp)
    (call $println_int)
    (get_global $fp)
    (get_global $fp)
    (i32.load)
    (set_global $fp)
    (set_global $sp)
    ;; (ExprStmt ("f(x)" "[void]" (Var "println_int" "0,5" "[(integer)void]") ( (== "[integer]" (Var "x" "5,0" "[integer]") (Var "y" "5,1" "[integer]")))))
    (get_global $fp)
    (i32.const 4)
    (i32.add)
    (i32.load)
    (get_global $fp)
    (i32.const 8)
    (i32.add)
    (i32.load)
    (i32.eq)
    (get_global $sp)
    (get_global $fp)
    (i32.store)
    (get_global $sp)
    (set_global $fp)
    (call $println_int)
    (get_global $fp)
    (get_global $fp)
    (i32.load)
    (set_global $fp)
    (set_global $sp)
    ;; (return (Integer "[integer]" 0))
    (i32.const 0)
    (return)
  ;; }
  (get_global $sp)
  (i32.const 12)
  (i32.sub)
  (set_global $sp)
  )

)
