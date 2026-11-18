sum_columns:
    addi sp, sp, -48 # make room
    sw ra, 44(sp)
    sw s0, 40(sp) #s0= nrow

    sw s1, 36(sp) # s1= ncol
    sw s2, 32(sp) #s2= i
    sw s3, 28(sp) #s3= k

    sw s4, 24(sp) #s4= point to sum[k]
    sw s5, 20(sp) #s5= point to matrix[i][k]
    sw s6, 16(sp) #sum array
    sw s7, 12(sp) #s7= OW marker

    or s0, a1, zero
    or s1, a2, zero
    or s5, a0, zero #s5 =&matrix(0,0)

    or s6, a3, zero # s6= &sum[0] (starting array pos)
    xor s2, s2, s2
    xor s7, s7, s7 #

row_loop: #outside loop
    bge s2, s0, done # if i greater than or equal to nrow go to done
    xor s3, s3, s3 #k=0
     or s4, s6, zero #q = &sum[0] (the start of it again

col_loop: #inside loop, goes across one row
    bge s3, s1, col_done # if k greater or equal to ncol, current row finsihes go to done
    lw a0, 0(s4) #a0 =sum[k]
