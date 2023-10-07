ASM = nasm
ASM_FLAGS = -f elf64
CC = clang
CC_FLAGS = -c -target x86_64-unknown-linux-gnu
LD = ld
SRC = src
BUILD = build
EXECUTABLE_NAME = out.bin

#malloc_test:
#	$(CC) $(CC_FLAGS) -c -o $(BUILD)/malloc_test.o $(SRC)/test/malloc_test.c
#	$(ASM) $(ASM_FLAGS) $(SRC)/lib/malloc.asm -o $(BUILD)/malloc.o
#	$(LD) -o $(BUILD)/$(EXECUTABLE_NAME) $(BUILD)/malloc_test.o $(BUILD)/malloc.o
#	./$(BUILD)/$(EXECUTABLE_NAME)