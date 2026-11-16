#SECTION 1: UNSIGNED COLUMN SUM:
#in:  a0= x, a1=y
#out: a0= x + y, a1=1 if overflow else 0
sum_columns:
    sum_columns:
    addi sp, sp, -48 #make room stack for 10 words 
    sw   ra, 44(sp) #save ra
    sw   s0, 40(sp) #s0

