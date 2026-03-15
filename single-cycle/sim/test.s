# --------------------------------
# LUI test
# --------------------------------
lui x1, 0x12345        # x1 = 0x12345000


# --------------------------------
# AUIPC test
# --------------------------------
auipc x2, 0x1          # x2 = PC + 0x1000


# --------------------------------
# JAL test
# --------------------------------
jal x3, jal_target

addi x4, x0, 111       # should be skipped

jal_target:
addi x4, x0, 4         # expect x4 = 4


# --------------------------------
# JALR test
# --------------------------------

# compute address of target using AUIPC
auipc x5, 0
addi  x5, x5, 16       # offset to jalr_target

jalr x6, 0(x5)

addi x7, x0, 111       # skipped

jalr_target:
addi x7, x0, 7         # expect x7 = 7
