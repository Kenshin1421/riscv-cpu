sim: obj bin hex clean

obj:
	riscv64-linux-gnu-as -march=rv32i sim/test.s -o sim/test.o
bin:
	riscv64-linux-gnu-objcopy -O binary sim/test.o sim/test.bin
hex:
	hexdump -v -e '1/4 "%08x\n"' sim/test.bin > sim/program.hex
clean:
	rm -f sim/test.o sim/test.bin



build: compile run

compile:
	iverilog -o cpu_sim src/core/cpu.v src/core/datapath.v src/core/control_unit.v src/blocks/PC.v src/utils/adder_32bit.v src/memory/InstructionMemory.v src/blocks/ALU.v src/blocks/RegisterFile.v sim/cpu_tb_new.v
run:
	vvp cpu_sim
wave:
	gtkwave dump.vcd