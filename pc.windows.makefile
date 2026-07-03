# Windows-compatible Makefile for PineappleCAS
# Original pc.makefile by yanick.rochon@gmail.com
# Windows adaptation by DaiGianna Williams - GitHub: dwilliams808 - Website: daigianna.com)
TARGET   = pineapple.exe

CC       = gcc
CFLAGS   = -std=c89 -ansi -pedantic -g -DCOMPILE_PC -DDEBUG -Wall -I.

LINKER   = gcc
LFLAGS   = -Wall -I. -lm

SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/*/*.c) $(wildcard $(SRCDIR)/*/*/*.c)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

$(BINDIR)/$(TARGET): $(OBJECTS)
	@if not exist $(subst /,\,$(@D)) mkdir $(subst /,\,$(@D))
	@$(LINKER) $(OBJECTS) $(LFLAGS) -o $@
	@echo Linking complete!

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	@if not exist $(subst /,\,$(@D)) mkdir $(subst /,\,$(@D))
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo Compiled $< successfully!

.PHONY: clean
clean:
	@if exist $(subst /,\,$(OBJDIR)) rmdir /s /q $(subst /,\,$(OBJDIR))
	@echo Cleanup complete!

.PHONY: remove
remove: clean
	@if exist $(BINDIR)/$(TARGET) del $(subst /,\,$(BINDIR)/$(TARGET))
	@echo Executable removed!