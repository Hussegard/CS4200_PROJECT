#SECTION 2:
# same do_add fn
do_add:
    xor t2, t2, t2 #t2 is the OW mark so it = 0
do_add_loop:
    and t0, a0, a1 # t0= the carry
    xor a0,a0, a1 # a0 = sum without carrys
    srli t1, t0,31 # t1= top bit of the carries, carry out of 31 means OW
    or t2, t2, t1 #keep if it was = 1
    slli a1, t0, 1 # a1 =the carries moved up one bit
    bne a1, zero, do_add_loop # go around agin if it goes left
    or a1,t2, zero # a1= OW marker
    ret

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
    bge s3,s1, col_done # if k greater or equal to ncol, current row finsihes go to done
    lw a0, 0(s4) #a0 =sum[k]
    lw a1, 0(s5) # a1=matrix(i,k)

    jal ra, do_add #a0=sum[k] + matrix[i][k], a1= OW flag
    sw a0, 0(s4) #write total again inside sum[k]
    or s7, s7, a1 #mark set if any add OW

    or a0, s5, zero #a0= p
    ori a1,zero, 4 # a1 = 4 (1 word)
    jal ra, do_add # a0= p+4, next number in the same row

    or s5, a0, zero # p = new addr
    or a0, s4, zero #a0= q
    ori a1, zero, 4 #a1 = 4

    jal ra, do_add #a0= q+4 (grab the one infront of it now)
    or s4, a0, zero # q = that new address
    or a0, s3, zero # a0 = k

    ori a1, zero, 1
    jal ra, do_add #a0= k + 1
    or s3, a0,zero #k = k++

    j col_loop
col_done: # finished one row, start setting up the next one
    or a0,s2, zero #a0= i
    ori a1, zero,1 #a1= 1
    jal ra, do_add #a0= i + 1

    or s2,a0, zero #i++
    j row_loop #jump

done:
    or a0, s7 #a0 holds OW mark

    #load the previously stored registers
    lw ra, 44(sp)
    lw 

    lw s0, 40(sp)
    lw s1, 36(sp)
    lw s2, 32(sp)
    lw s3, 28(sp)

    lw s4, 24(sp)
    lw s5, 22(sp)
    lw s6, 18(sp)
    lw s7, 12(sp)

    addi sp, sp, 48
    ret

