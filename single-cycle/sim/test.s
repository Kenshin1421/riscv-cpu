#Test for Branch Instructions by ChatGpt
# ----------------------------
# BEQ taken
# ----------------------------
addi x1, x0, 5
addi x2, x0, 5

beq x1, x2, beq_taken
addi x3, x0, 111      # should skip

beq_taken:
addi x3, x0, 1        # expect x3 = 1


# ----------------------------
# BNE taken
# ----------------------------
addi x4, x0, 7
addi x5, x0, 8

bne x4, x5, bne_taken
addi x6, x0, 111      # skip

bne_taken:
addi x6, x0, 2        # expect x6 = 2


# ----------------------------
# BLT (signed)
# ----------------------------
addi x7, x0, -3
addi x8, x0, 2

blt x7, x8, blt_taken
addi x9, x0, 111      # skip

blt_taken:
addi x9, x0, 3        # expect x9 = 3


# ----------------------------
# BGE (signed)
# ----------------------------
addi x10, x0, 4
addi x11, x0, -1

bge x10, x11, bge_taken
addi x12, x0, 111     # skip

bge_taken:
addi x12, x0, 4       # expect x12 = 4


# ----------------------------
# BLTU (unsigned)
# ----------------------------
addi x13, x0, -1      # 0xFFFFFFFF
addi x14, x0, 1

bltu x14, x13, bltu_taken
addi x15, x0, 111     # skip

bltu_taken:
addi x15, x0, 5       # expect x15 = 5


# ----------------------------
# BGEU (unsigned)
# ----------------------------
addi x16, x0, -1
addi x17, x0, 1

bgeu x16, x17, bgeu_taken
addi x18, x0, 111     # skip

bgeu_taken:
addi x18, x0, 6       # expect x18 = 6
