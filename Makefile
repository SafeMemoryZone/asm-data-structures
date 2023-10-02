CC = nasm
CC_FLAGS = -f elf64
LD = ld
SRC = src
BUILD = build
EXECUTABLE_NAME = executable.bin

array:
	$(CC) $(CC_FLAGS) $(SRC)/array.asm -o $(BUILD)/array.o
	$(LD) -o $(BUILD)/$(EXECUTABLE_NAME) $(BUILD)/array.o
	./$(BUILD)/$(EXECUTABLE_NAME)