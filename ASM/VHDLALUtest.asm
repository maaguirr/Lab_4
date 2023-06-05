# VHDL ALU TEST

.text
main:

# adding 4 + 3
li a0, 4
li a1, 3
add s2, a0, a1

# addi when DataIn2 = 3
addi s3, a0, 3

#subtracting 3 from 4
sub s4, a0, a1

#bitwise and
li a0, 15
li a1, 0
and s5, a0, a1

#bitwise andi
andi s6, a0, 15

#or
li a0, 15
li a1, 240
or s7 a0, a1

#ori
ori s8, a0, 0

#sll
li a0, 6
li a1, 2
sll s9, a0, a1

#slli
slli s10, a0, 3

#srl
li a0, 6
li a1, 2
srl s11, a0, a1

#srli
srli t3, a0, 3

li a7, 10
ecall