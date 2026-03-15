# -------------------------
# base address
# -------------------------
addi x1, x0, 0


# -------------------------
# SB test
# store 0xAA at address +1
# -------------------------
addi x2, x0, 170      # 0xAA
sb x2, 1(x1)

lw x3, 0(x1)          # expect 0x1122AA44


# -------------------------
# SH test
# build 0xBBBB
# -------------------------
addi x4, x0, 187      # 0xBB
slli x4, x4, 8
addi x4, x4, 187      # x4 = 0xBBBB

sh x4, 2(x1)

lw x5, 0(x1)          # expect 0xBBBB3344


# -------------------------
# SW test
# build 0xDEADBEEF
# -------------------------
addi x6, x0, 0xDE
slli x6, x6, 24

addi x7, x0, 0xAD
slli x7, x7, 16
add x6, x6, x7

addi x7, x0, 0xBE
slli x7, x7, 8
add x6, x6, x7

addi x7, x0, 0xEF
add x6, x6, x7        # x6 = 0xDEADBEEF

sw x6, 0(x1)

lw x7, 0(x1)          # expect 0xDEADBEEF


# -------------------------
# SB test on second word
# -------------------------
addi x8, x0, 153      # 0x99

sb x8, 4(x1)

lw x9, 4(x1)          # expect 0x55667799
