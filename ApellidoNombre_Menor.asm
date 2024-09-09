# ApellidoNombre_Menor.asm
.data
    prompt: .asciiz "Ingrese la cantidad de números a comparar (3-5): "
    num_prompt: .asciiz "Ingrese un número: "
    result: .asciiz "El número menor es: "
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

    # Encontrar el número menor
    la $t2, nums
    lw $t3, 0($t2)  # Menor inicial
    li $t1, 4

find_min:
    lw $t4, 0($t2)
    bgt $t3, $t4, update_min
    j next

update_min:
    move $t3, $t4

next:
    addi $t2, $t2, 4
    subi $t0, $t0, 1
    bnez $t0, find_min

    # Mostrar el resultado
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 10
    syscall