ASM = nasm
ASM_FLAGS = -f elf64
CC = gcc
CC_FLAGS = -c -m64 -Wall -g -Werror
LD = gcc
SRC = src
BUILD = build
EXECUTABLE_NAME = out

test:
	$(CC) $(CC_FLAGS) -c -o $(BUILD)/test.o $(SRC)/test/main.c
	$(ASM) $(ASM_FLAGS) $(SRC)/lib/lib.asm -o $(BUILD)/lib.o
	$(LD) -o $(BUILD)/$(EXECUTABLE_NAME) $(BUILD)/test.o $(BUILD)/lib.o
	./$(BUILD)/$(EXECUTABLE_NAME)