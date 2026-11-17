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


    or s0,a1, zero #s0 = nrow (overriding a1 so copy it now)
    or s1, a2, zero
    or s6, a0, zero #s6= &matrix (0,0) starts at base


    or s4, a3, zero #s4 =&sum of 0
    slli s7, s1, 2 #stride= ncol * 4
    xor s2, s2, s2 #i =0 (xor a reg withitself = 0)


    xor s8, s8, s8 #overflow flag = 0
col_loop: #one pass per column (this is the outside loop)
    bge s2,s1, done # if i greater than or equal to ncol, then every column is ran through, jump to done
    sw zero, 0(s4) # sum[i ] =0
    xor s3, s3, s3 
    or s5,s6, zero

