#SECTION 1: UNSIGNED COLUMN SUM
sum_columns:
    addi sp, sp, -48 #make room stack for 10 words 
    sw ra, 44(sp) #save ra
    sw s0, 40(sp) #s0


    sw s1, 36(sp) #s1=ncol
    sw s2, 32(sp) #s2 =i
    sw s3, 28(sp) #s3=k
    sw s4, 24(sp)  #s4=pointer to sum of i


    sw s5, 20(sp) #s5= pointer to matrix(k,i)
    sw s6, 16(sp) #s6 is thestart of the column that we're on
    sw s7, 12(sp) #s7 is for row
    sw s8, 8(sp) #s8 is for the iverflow
