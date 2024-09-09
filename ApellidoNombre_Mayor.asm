# ApellidoNombre_Mayor.asm
.data
    prompt: .asciiz "Ingrese la cantidad de números a comparar (3-5): "
    num_prompt: .asciiz "Ingrese un número: "
    result: .asciiz "El número mayor es: "
    nums: .word 0, 0, 0, 0, 0

.text
.globl main

main:
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Guardar la cantidad de números en $t0

    # Leer los números
    li $t1, 0  # Índice
read_numbers:
    li $v0, 4
    la $a0, num_prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, nums($t1)

    addi $t1, $t1, 4
    subi $t0, $t0, 1
    bnez $t0, read_numbers

    # Encontrar el número mayor
    la $t2, nums
    lw $t3, 0($t2)  # Mayor inicial
    li $t1, 4

find_max:
    lw $t4, 0($t2)
    blt $t3, $t4, update_max
    j next

update_max:
    move $t3, $t4

next:
    addi $t2, $t2, 4
    subi $t0, $t0, 1
    bnez $t0, find_max

    # Mostrar el resultado
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 10
    syscall