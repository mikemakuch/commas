

UNAME := $(shell uname -s)

.SUFFIXES:
	MAKEFLAGS += --no-builtin-rules

ifeq ($(UNAME), Linux)
CFLAGS = -std=c++11 -Wall 
CC = g++
COMPILE = $(CC) $(CFLAGS) $< -o $@
BINS = $(subst .cpp,,$(SRCS))
endif

ifeq ($(UNAME), Darwin)
CC = /opt/local/bin/g++-mp-4.7
CFLAGS = -std=c++11  -L/opt/local/lib -I/opt/local/include -g
COMPILE = $(CC) $(CFLAGS) $< -o $@
BINS = $(subst .cpp,,$(SRCS))
endif

ifneq (,$(findstring CYGWIN_NT,$(UNAME)))
CC=cl
CFLAGS=/O2 /nologo 
#LIBS=gdi32.lib user32.lib kernel32.lib shell32.lib winmm.lib opengl32.lib glu32.lib
LIBS=user32.lib kernel32.lib shell32.lib
COMPILE = cl /EHsc $?  /Fe$(subst .cpp,.exe,$?)  ;  rm $(OBJ)
OBJ = $(addsuffix .obj,$@)
BINS = $(subst .cpp,.exe,$(SRCS))
endif

SRCS = $(shell ls *.cpp)

% :	%.cpp
	$(COMPILE)

commas : commas.cpp
	$(COMPILE)

clean:
	rm -rf $(BINS) *.dSYM *.obj *.exe



