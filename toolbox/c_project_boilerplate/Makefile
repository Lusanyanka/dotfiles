.PHONY: clean

CC=gcc
WARNINGS=-Wall -Wextra -pedantic -Wshadow -Wpointer-arith \
		 -Wcast-align -Wwrite-strings -Wmissing-prototypes \
		 -Wmissing-declarations -Wredundant-decls -Wnested-externs \
		 -Winline -Wuninitialized -Wconversion -Wstrict-prototypes \
		 -Werror=implicit-function-declaration \
		 -Werror=incompatible-pointer-types
CFLAGS=-g -O0 $(WARNINGS)
CLIBS=

SRC=$(shell find src -type f -name "*.c")
OBJS=$(patsubst %.c,%.o,$(SRC))
DEPS=$(patsubst %.c,%.d,$(SRC))
TARGET=a.out

all: $(TARGET)

-include $(DEPS)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(CLIBS) -o $(TARGET)

%.o: %.c Makefile
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

clean:
	$(RM) $(wildcard $(OBJS) $(DEPS) $(TARGET))
