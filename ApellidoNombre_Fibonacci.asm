# ApellidoNombre_Fibonacci.asm
.data
    prompt: .asciiz "Ingrese la cantidad de números de la serie Fibonacci: "
    result: .asciiz "La serie Fibonacci es: "
    sum_result: .asciiz "La suma de la serie es: "
    nums: .word 0:50  # Espacio para 50 números

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

    # Generar la serie Fibonacci
    li $t1, 0  # Índice
    li $t2, 0  # Primer número
    li $t3, 1  # Segundo número

generate_fib:
    sw $t2, nums($t1)
    add $t4, $t2, $t3
    move $t2, $t3
    move $t3, $t4

    addi $t1, $t1, 4
    subi $t0, $t0, 1
    bnez $t0, generate_fib

    # Mostrar la serie
    li $v0, 4
    la $a0, result
    syscall

    la $t1, nums
    li $t0, 0  # Reiniciar contador

print_fib:
    lw $a0, 0($t1)
    li $v0, 1
    syscall

    addi $t1, $t1, 4
    subi $t0, $t0, 1
    bnez $t0, print_fib

    # Calcular la suma de la serie
    la $t1, nums
    li $t0, 0  # Reiniciar contador
    li $t5, 0  # Suma

sum_fib:
    lw $t4, 0($t1)
    add $t5, $t5, $t4

    addi $t1, $t1, 4
    subi $t0, $t0, 1
    bnez $t0, sum_fib

    # Mostrar la suma
    li $v0, 4
    la $a0, sum_result
    syscall

    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 10
    syscall