CC = nasm
CC_FLAGS = -f elf64
LD = ld
SRC = src
BUILD = build
EXECUTABLE_NAME = executable.bin
TARGETS = $(SRC)/lib/malloc.asm
OUTPUTS = $(BUILD)/malloc.o

all:
	$(CC) $(CC_FLAGS) $(TARGETS) -o $(OUTPUTS)
	$(LD) -o $(BUILD)/$(EXECUTABLE_NAME) $(OUTPUTS)
	./$(BUILD)/$(EXECUTABLE_NAME)