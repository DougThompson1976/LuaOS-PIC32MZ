BINDIR := /usr/local/gnu-mips/bin

SRCS=$(wildcard $(FOLDER)/*.s)

APP=$(BINDIR)/mips-elf-cpp -DLOCORE -P -I. -IFreeRTOS -IFreeRTOS/port -Imachine -D__LANGUAGE_ASSEMBLY__
AAS=$(BINDIR)/mips-elf-as -mdsp -mips32r2 -EL -mfp64 -G 0 -Os -o 

asm: $(SRCS)
	$(foreach SRC,$(SRCS), ($(APP) $(SRC) | $(AAS) $(patsubst %.s,%.o,$(SRC)));)
